module Rubycron
  module Formatters
    class YearFormatter < CronStruct
      def c
        "in #{collection.to_sentence}"
      end

      def e
        ''
      end

      def f
        "#{v} between #{start} and #{stop}"
      end

      def r
        "every year between #{start} and #{stop}"
      end

      def s
        ", #{single_element}"
      end

      def u
        "#{v} starting in #{start}"
      end

      def v
        "every #{frequency} years"
      end
    end
  end
end
