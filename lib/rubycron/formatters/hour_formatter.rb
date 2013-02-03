module Rubycron
  module Formatters
    class HourFormatter < CronStruct
      def name; 'hour'; end

      def e
        'every hour'
      end
      def f
        "#{v} between #{r}"
      end
      def v
        "every #{frequency.ordinal} hour"
      end
      def c
        collection.map{|hour| "#{hour.two_digits}:00 and #{hour.two_digits}:59" }.to_sentence
      end
      alias :s :c
      def r
        "#{self.start.two_digits}:00 and #{self.stop.two_digits}:59"
      end
    end
  end
end
