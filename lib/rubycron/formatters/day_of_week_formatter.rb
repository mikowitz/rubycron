module Rubycron
  module Formatters

    class DayOfWeekFormatter < CronStruct
      DAYS = %w{ Sunday Monday Tuesday Wednesday Thursday Friday Saturday }
      CRON_DAYS = %w{ sun mon tue wed thu fri sat }

      def sym
        return 'l' if !!last
        return 'n' if !!nth_week
        super
      end

      def get_weekday(day)
        if day =~ /[a-z]/i
          DAYS[CRON_DAYS.index(day.downcase)]
        else
          DAYS[day.to_i]
        end
      end

      def c(weekdays=collection)
        "every #{weekdays.map{|weekday| get_weekday(weekday)}.to_sentence}"
      end

      def e
        ""
      end

      def l
        "the last #{get_weekday(single_element)}"
      end

      def n
        "the #{nth_week.ordinal} #{get_weekday(single_element)}"
      end

      def r
        c(Array(start.to_i..stop.to_i))
      end

      def s
        "every #{get_weekday(single_element)}"
      end
    end
  end
end
