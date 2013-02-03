module Rubycron
  module Formatters
    class MinuteFormatter < CronStruct
      def c
        "the #{collection.map{|minute| minute.ordinal}.to_sentence} minutes"
      end

      def e
        'every minute'
      end

      def f(hours=nil)
        hours ||= ['xx']
        "#{v} between #{hours.map(&:two_digits).map{|hour| "#{hour}:#{start.two_digits} and #{hour}:#{stop.two_digits}"}.to_sentence}"
      end

      def r(hours=nil)
        hours ||= ['xx']
        "every minute between #{hours.map(&:two_digits).map{|hour| "#{hour}:#{start.two_digits} and #{hour}:#{stop.two_digits}"}.to_sentence}"
      end

      def s
        "the #{single_element.to_i == 0 ? "beginning" : "#{single_element.ordinal} minute"}"
      end

      def u(starting_at=true)
        starting_at ?  "#{v} starting at xx:#{start.two_digits}" : v
      end

      def v
        "every #{frequency} minutes"
      end
    end
  end
end
