module Rubycron
  module Formatters
    class MinuteFormatter < CronStruct
      def name; 'minute'; end

      def ordinal
        case single_element.to_i
        when 0 then 'beginning'
        else "#{single_element.to_i.ordinal} minute"
        end
      end

      def range(hour=nil)
        hour ||= 'xx'
        case self.stop.to_i
        when 59 then "starting at #{hour}:#{self.start.two_digits}"
        else "between #{hour}:#{self.start.two_digits} and #{hour}:#{self.stop.two_digits}"
        end
      end

      def e
        'every minute'
      end

      def s
        "the #{ordinal}"
      end
      def c
        "the #{collection.map{|minute| minute.ordinal}.to_sentence} minutes"
      end
      def v
        "every #{frequency} minutes"
      end
      def r(hours=nil)
        hours ||= ['xx']
        "every minute between #{hours.map(&:two_digits).map{|hour| "#{hour}:#{start.two_digits} and #{hour}:#{stop.two_digits}"}.to_sentence}"
      end
      def f(hours=nil)
        hours ||= ['xx']
        "#{v} between #{hours.map(&:two_digits).map{|hour| "#{hour}:#{start.two_digits} and #{hour}:#{stop.two_digits}"}.to_sentence}"
      end
    end
  end
end
