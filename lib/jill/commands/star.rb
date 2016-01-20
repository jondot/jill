require 'uri'
require 'json'
require 'open-uri'
require 'nokogiri'

module Jill
  module Commands
    class Star < Base
      STAR = '★'
      
      def setup(o)
        super
        o.string "--star-in", "Star input file", default: "README.md"
        o.string "--star-out", "Star output file", default: "README.md"
      end

      def help
        "Embed stars in markdown file"
      end

      def run_if_switched(opts)
        file = opts[:star_in]
        file_out = opts[:star_out]
        out = ""
        puts "Starring #{file}..."

        # do this serially as to not piss off github
        File.read(file).each_line do |line|
          # is a bullet,
          # starts with github.com,
          # has only 2 segments in path,
          # remove trailing slashes.
          if line =~ /^- \[(.*?)\]\(https?:\/\/github\.com\/([^\/]+?)\/([^\/]+?)\/?\)(\s+.*)$/
            begin
              ghslug = "#{$2}/#{$3}"
              rest = $4
              # remove existing stars if existing
              name = $1.gsub(/\s?#{STAR}\d+/, '')

              doc = Nokogiri::HTML(open("https://github.com/#{ghslug}").read)
              stars = doc.css('.js-social-count').text.strip.gsub(',','')

              out <<  "- [#{name} #{STAR}#{stars}](https://github.com/#{ghslug})#{rest}\n"
            rescue
              out << line
              out << "<!-- error fetching stars for #{ghslug}: #{$!} -->\n"
            end
            putc "."

          else
            out << line
          end
        end
        File.open(file_out, "w"){|f| f.write(out)}
        puts "\nDone."

        return true
      end
    end
  end
end
