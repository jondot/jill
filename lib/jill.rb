require "jill/version"
require "jill/commands/base"

require "jill/commands/dedup"
require "jill/commands/star"
require "jill/commands/links"

module Jill
  class Runner
    def initialize
      @commands = [
        Commands::Star.new,
        Commands::Dedup.new,
        Commands::Links.new
      ]
    end

    def setup(o)
      @commands.each{|c| c.setup(o) }
    end

    def run(opts)
      @commands.map{|c| c.run(opts) }.inject(true){|a,s| a && s}
    end
  end
end

