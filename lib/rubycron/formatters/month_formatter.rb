module Rubycron
  module Formatters
    class MonthFormatter < CronStruct
      MONTHS = %w{ January February March April May June July August September October November December }
      CRON_MONTHS = %w{ jan feb mar apr may jun jul aug sep oct nov dec }

      def get_month(month)
        if month =~ /[a-z]/i
          MONTHS[CRON_MONTHS.index(month.downcase)]
        else
          MONTHS[month.to_i - 1]
        end
      end

      def range
        "from #{s(start)} to #{s(stop)}"
      end

      def c
        collection.map{|month| get_month(month)}.to_sentence
      end

      def e
        "every month"
      end

      def f
        "every #{frequency.ordinal} month #{range}"
      end

      def r
        "every month #{range}"
      end

      def s(month=single_element)
        get_month(month)
      end

      def v
        "every #{frequency.ordinal} month"
      end
    end
  end
end
