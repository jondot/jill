module Jill
  module Commands
    class Base
      def setup(o)
        o.bool "-#{flagname[0]}", "-#{flagname}", help
      end

      def run(opts)
        return unless opts[flagname.to_sym]
        run_if_switched(opts)

      end

      def run_if_switched(opts)
      end

      def help
        ""
      end

      def flagname
        @flagname ||= self.class.name.split("::").last.downcase
        @flagname
      end
    end
  end
end

