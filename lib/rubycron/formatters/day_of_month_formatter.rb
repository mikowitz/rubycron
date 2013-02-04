module Rubycron
  module Formatters
    class DayOfMonthFormatter < CronStruct
      def ordinal; self.single_element.ordinal; end

      def range
        "the #{self.start.ordinal} to the #{self.stop.ordinal}"
      end

      def sym
        return 'w' if !!nearest
        return 'l' if !!last
        super
      end

      def c(lead_in=true)
        "#{"on the " if lead_in}#{collection.map(&:ordinal).to_sentence}"
      end

      def e
        "on every day"
      end

      def f
        "#{v} from #{range}"
      end

      def l
        "on the last day"
      end

      def r
        "on #{range}"
      end

      def s(lead_in=true)
        "#{"on the " if lead_in}#{ordinal}"
      end

      def u
        "#{v} starting on the #{start.ordinal}"
      end

      def v
        "on every #{frequency.ordinal} day"
      end

      def w
        "on the weekday closest to the #{ordinal}"
      end
    end
  end
end
