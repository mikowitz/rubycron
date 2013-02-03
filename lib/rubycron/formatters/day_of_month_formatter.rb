module Rubycron
  module Formatters
    class DayOfMonthFormatter < CronStruct
      def name; 'day'; end
      def last_day_of?; !!last; end
      def nearest_weekday_to?; !!nearest; end
      def every_day?; every? && !frequency? && !range? && !collection?; end
      def single_day?; collection? && self.collection.size == 1; end
      def ordinal; self.single_element.ordinal; end
      def collection_ordinals
        "#{collection.map(&:ordinal).to_sentence}"
      end
      def range
        "the #{self.start.ordinal} to the #{self.stop.ordinal}"
      end

      def to_s
        return 'w' if nearest_weekday_to?
        return 'l' if last_day_of?
        super
      end

      def e
        "on every day"
      end
      def f
        "#{v} from #{range}"
      end
      def v
        "on every #{frequency.ordinal} day"
      end
      def r
        "on #{range}"
      end
      def s(lead_in=true)
        "#{"on the " if lead_in}#{ordinal}"
      end
      def c(lead_in=true)
        "#{"on the " if lead_in}#{collection_ordinals}"
      end
      def l
        "on the last day"
      end
      def w
        "on the weekday closest to the #{ordinal}"
      end
    end
  end
end
