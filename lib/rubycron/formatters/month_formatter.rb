module Rubycron
  module Formatters
    class MonthFormatter < CronStruct
      def every_month?; every? && !frequency? && !range? && !collection?; end
      def single_month?; collection? && self.collection.size == 1; end

      def range
        "from #{s(start)} to #{s(stop)}"
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
      def v
        "every #{frequency.ordinal} month"
      end
      def s(month=single_element)
        if month =~ /[a-z]/i
          MONTHS[CRON_MONTHS.index(month.downcase)]
        else
          MONTHS[month.to_i - 1]
        end
      end
      def c
        collection.map{|month| s(month)}.to_sentence
      end
    end
  end
end
