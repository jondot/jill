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
        o.string "--freshness", "Freshness", default: "0"
      end

      def help
        "Embed stars in markdown file"
      end

      def run_if_switched(opts)
        file = opts[:star_in]
        file_out = opts[:star_out]
        freshness_secs = opts[:freshness].to_i

        out = ""
        puts "Starring #{file}..."

        # do this serially as to not piss off github
        File.read(file).lines.each_with_index do |line, idx|
          # is a bullet,
          # starts with github.com,
          # has only 2 segments in path,
          # remove trailing slashes.
          if line =~ /^- (.*?)\[(.*?)\]\(https?:\/\/github\.com\/([^\/]+?)\/([^\/]+?)\/?\)(\s+.*)$/
            badges = $1.split
            
            if freshness_secs > 0
              badges = badges.reject{|b| b.start_with?(':pineapple:')}
              if fresh?(file, idx, freshness_secs)
                badges << ':pineapple:'
              end
            end
            tag = badges.join(' ')

            begin
              ghslug = "#{$3}/#{$4}"
              rest = $5.chomp
              # remove existing stars if existing
              name = $2.gsub(/\s?#{STAR}\d+/, '')

              doc = Nokogiri::HTML(open("https://github.com/#{ghslug}").read)
              stars = doc.css('.js-social-count').text.strip.gsub(',','')

              out <<  "- #{tag}[#{name} #{STAR}#{stars}](https://github.com/#{ghslug})#{rest}\n"
            rescue
              out << line
              puts "<!-- error fetching stars for #{ghslug}: #{$!} -->"
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

      private

      def fresh?(file, ln, fresh_time)
        out = `git blame #{file} -L #{ln+1},#{ln+1} -p`
        ts = out.lines.find{|ln| ln.start_with?('author-time')}.split('author-time ')[1].to_i
        (Time.now - Time.at(ts)) < fresh_time
      end

    end
  end
end
