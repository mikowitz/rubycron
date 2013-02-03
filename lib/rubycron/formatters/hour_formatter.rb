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
        "#{self.start.two_digits}:00 and #{self.stop.two_digits}:59"
      end

      alias :s :c

      def v
        "every #{frequency.ordinal} hour"
      end
    end
  end
end
