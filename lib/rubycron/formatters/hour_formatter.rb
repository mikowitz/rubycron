module Rubycron
  module Formatters
    class HourFormatter < CronStruct
      def c
        collection.map{|hour| "#{hour.two_digits}:00 and #{hour.two_digits}:59" }.to_sentence
      end

      def e
        'every hour'
      end

      def f
        "#{v} between #{r}"
      end

      def r
        "#{start.two_digits}:00 and #{stop.two_digits}:59"
      end

      alias :s :c

      def u
        "#{v} starting at #{start.two_digits}:00"
      end

      def v
        "every #{frequency.ordinal} hour"
      end
    end
  end
end
