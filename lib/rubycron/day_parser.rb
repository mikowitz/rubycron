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
      day = DayHash.new(Parser.new(@day).parse)
      month = MonthHash.new(Parser.new(@month).parse)
      weekday = WeekdayHash.new(Parser.new(@weekday).parse)

      case [day, month, weekday].map(&:to_s).join('')
      when 'eee' then 'every day'
      # 'on May 22nd,' not 'on the 22nd of May'
      when /^[sc]s.$/ then "on #{month.s} #{day.send(day.to_s, false)}"
      # 'on the weekday(s) closest to May 22nd,' not 'on the weekday(s) closest to the 22nd of May'
      when /^ws.$/ then "on the weekday closest to #{month.send(month.to_s)} #{day.s(false)}"
      when /^wc.$/ then "on the weekdays closest to #{month.send(month.to_s)} #{day.s(false)}"
      else "%s of %s" % [day.send(day.to_s), month.send(month.to_s)]
      end
    end

    def to_month(month)
      MONTHS[CRON_MONTHS.index(month.downcase) || month.to_i - 1]
    end

    def to_weekday(weekday)
      DAYS[CRON_DAYS.index(weekday.downcase) || weekday.to_i]
    end
  end
end
