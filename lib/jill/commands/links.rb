require 'parallel'
require 'nokogiri'
require 'open-uri'
require 'httparty'
require 'kramdown'

module Jill
  module Commands
    class Links < Base
      def setup(o)
        super
        o.string "--links-base-url", "Links base url", default: "/"
        o.string "--links-file", "Links input file", default: "README.md"
      end
      
      def help
        "Validate live links out of a markdown file"
      end

      def run_if_switched(opts)
        file = opts[:links_file]
        base_url = opts[:links_base_url]

        doc = Nokogiri::HTML(Kramdown::Document.new(open(file).read).to_html)
        links = doc.css('a').to_a
        puts "Validating #{links.count} links..."

        invalids = []
        Parallel.each(links, :in_threads => 4) do |link|
          begin
            uri = URI.join(base_url, link.attr('href'))
            check_link(uri)
            putc('.')
          rescue
            putc('F')
            invalids << "#{link} (reason: #{$!})"
          end
        end

        unless invalids.empty?
          puts "\n\nFailed links:"
          invalids.each do |link|
            puts "- #{link}"
          end
          puts "Done with errors."
          exit(1)
        end

        puts "\nDone."
      end
      def check_link(uri)
        code = HTTParty.head(uri, :follow_redirects => false).code
        return code >= 200 && code < 400
      end
    end
  end
end

