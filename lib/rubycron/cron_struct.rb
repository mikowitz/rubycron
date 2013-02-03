require 'ostruct'

module Rubycron
  class CronStruct < OpenStruct
    MONTHS = %w{ January February March April May June July August September October November December }
    CRON_MONTHS = %w{ jan feb mar apr may jun jul aug sep oct nov dec }
    DAYS = %w{ Sunday Monday Tuesday Wednesday Thursday Friday Saturday }
    CRON_DAYS = %w{ sun mon tue wed thu fri sat }
    def every?; !!self.every; end
    def frequency?; !!self.frequency; end
    def range?; !!self.start; end
    def collection?; !!self.collection; end

    def every_every?; every? && !frequency? && !range? && !collection?; end
    def single_element?; collection? && self.collection.size == 1; end

    def single_element; collection[0]; end

    def collection_ordinals
      "the #{collection.map(&:ordinal).to_sentence} #{self.name}s"
    end

    def to_s
      return "e" if every_every?
      return "f" if frequency? && range?
      return "v" if frequency?
      return "r" if range?
      return "s" if single_element?
      return "c" if collection?
    end
  end

  class MinuteHash < CronStruct
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
  end

  class HourHash < CronStruct
    def name; 'hour'; end

    def within_range
      "#{self.start.two_digits}:00 and #{self.stop.two_digits}:59"
    end

    def within_collection
      self.collection.map{|hour| "#{hour.two_digits}:00 and #{hour.two_digits}:59" }.to_sentence
    end
  end

  class DayHash < CronStruct
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

  class MonthHash < CronStruct
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

  class WeekdayHash < CronStruct
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
