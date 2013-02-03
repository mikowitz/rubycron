module Rubycron
  module Formatters

    class DayOfWeekFormatter < CronStruct
      def every_weekday?; every? && !frequency? && !range? && !collection?; end
      def single_weekday?; collection? && self.collection.size == 1; end
      def last_weekday?; !!last; end
      def nth_week?; !!nth_week; end

      def to_s
        return 'l' if last_weekday?
        return 'n' if nth_week?
        super
      end

      def weekday(day)
        if day =~ /[a-z]/i
          DAYS[CRON_DAYS.index(day.downcase)]
        else
          DAYS[day.to_i]
        end
      end

      def e
        ""
      end
      def s
        "every #{weekday(single_element)}"
      end
      def c(weekdays=collection)
        "every #{weekdays.map{|weekday| weekday(weekday)}.to_sentence}"
      end
      def r
        c(Array(start.to_i..stop.to_i))
      end
      def l
        "the last #{weekday(single_element)}"
      end
      def n
        "the #{nth_week.ordinal} #{weekday(single_element)}"
      end
    end

  end
end
