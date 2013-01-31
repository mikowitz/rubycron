module Rubycron
  class DayParser
    MONTHS = %w{ January February March April May June July August September October November December }
    CRON_MONTHS = %w{ jan feb mar apr may jun jul aug sep oct nov dec }

    DAYS = %w{ Sunday Monday Tuesday Wednesday Thursday Friday Saturday }
    CRON_DAYS = %w{ sun mon tue wed thu fri sat }
    def initialize(day, month, weekday)
      @day, @month, @weekday = day, month, weekday
    end

    def self.parse(day, month, weekday)
      new(day, month, weekday).parse
    end

    def parse
      # simplest case
      day = DayHash.new(Parser.new(@day).parse)
      month = MonthHash.new(Parser.new(@month).parse)
      weekday = WeekdayHash.new(Parser.new(@weekday).parse)
      return 'every day' if day.every_day? && month.every_month? && weekday.every_weekday?
      if weekday.every_weekday?
        if month.every_month?
          if day.single_day?
            "on the #{day.collection[0].to_i.ordinal} of every month"
          end
        elsif month.single_month?
          m = month.collection[0]
          m_idx = CRON_MONTHS.index(m.downcase) || m.to_i - 1
          if day.single_day?
            "on #{MONTHS[m_idx]} #{day.collection[0].to_i.ordinal}"
          end
        elsif month.collection?
          if day.every_day?
            "every day in #{month.collection.map{|m| to_month(m)}.to_sentence}"
          elsif day.collection?
            "on the #{day.collection.map{|d| d.to_i.ordinal}.to_sentence} of #{month.collection.map{|m| to_month(m)}.to_sentence}"
          end
        end
      elsif weekday.single_weekday?
        if day.every? && month.every?
          "every #{to_weekday(weekday.weekday)}"
        elsif day.single_element? && month.single_element?
          "on #{to_month(month.single_element)} #{day.collection[0].to_i.ordinal} if it is a #{to_weekday(weekday.weekday)}"
        end
      elsif weekday.collection?
        if day.every? && month.every?
          "every #{weekday.collection.map{|w| to_weekday(w)}.to_sentence}"
        end
      elsif weekday.range?
      end
    end

    def to_month(month)
      MONTHS[CRON_MONTHS.index(month.downcase) || month.to_i - 1]
    end

    def to_weekday(weekday)
      DAYS[CRON_DAYS.index(weekday.downcase) || weekday.to_i]
    end
  end

  class DayHash < CronStruct
    def every_day?; every? && !frequency? && !range? && !collection?; end
    def single_day?; collection? && self.collection.size == 1; end
  end

  class MonthHash < CronStruct
    def every_month?; every? && !frequency? && !range? && !collection?; end
    def single_month?; collection? && self.collection.size == 1; end
  end

  class WeekdayHash < CronStruct
    def every_weekday?; every? && !frequency? && !range? && !collection?; end
    def single_weekday?; collection? && self.collection.size == 1; end

    def weekday; self.collection[0]; end
  end
end
