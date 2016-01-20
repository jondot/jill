require 'parallel'
require 'nokogiri'
require 'open-uri'
require 'kramdown'

module Jill
  module Commands
    class Dedup < Base
      def setup(o)
        super
        o.string "--dedup-base-url", "Dedup base url", default: "/"
        o.string "--dedup-file", "Dedup input file" , default: "README.md"
      end

      def help
        "Dedups links out of a markdown file"
      end

      def run_if_switched(opts)
        file = opts[:dedup_file]
        base_url = opts[:dedup_base_url]

        doc = Nokogiri::HTML(Kramdown::Document.new(open(file).read).to_html)
        links = doc.css('a').to_a
        puts "Deduping #{links.count} links..."

        map = {}
        dups = []

        links.each do |link|
          uri = URI.join(base_url, link.attr('href'))
          if map[uri]
            dups <<  link
          end
          map[uri] = link
        end

        unless dups.empty?
          puts "\nDuplicate links:"
          dups.each do |link|
            puts "- #{link}"
            puts `grep -nr '#{link.attr('href')}' #{file}`
          end
          puts "\nDone with errors."
          return false
        end

        puts "\nDone."

        return true
      end
    end
  end
end

