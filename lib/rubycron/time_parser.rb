module Rubycron
  class TimeParser
    def initialize(minute, hour)
      @minute, @hour = minute, hour
    end

    def self.parse(minute, hour)
      new(minute, hour).parse
    end

    def parse
      minute = MinuteHash.new(Parser.new(@minute).parse)
      hour = HourHash.new(Parser.new(@hour).parse)

      return 'every minute' if minute.every_minute? && hour.every_hour?
      if hour.every?
        if minute.single_minute?
          case minute.collection[0].to_i
          when 0 then 'the beginning of every hour'
          else "at the #{minute.collection[0].to_i.ordinal} minute of every hour"
          end
        elsif minute.frequency?
          ret = "every #{minute.frequency} minutes"
          if minute.unbounded_range?
            ret += " of every hour starting at xx:#{minute.start.two_digits}"
          elsif minute.range?
            ret += " of every hour between xx:#{minute.start.two_digits} and xx:#{minute.stop.two_digits}"
          end
          ret
        elsif minute.range?
          "every minute of every hour between xx:#{minute.start.two_digits} and xx:#{minute.stop.two_digits}"
        elsif minute.collection?
          "at the #{minute.collection.map{|d| d.to_i.ordinal}.to_sentence} minutes of every hour"
        end
      elsif hour.single_hour?
        hour_range = "#{hour.collection[0].two_digits}:00 and #{(hour.collection[0] + 1).two_digits}:00"
        if minute.every_minute?
          "every minute between #{hour_range}"
        elsif minute.single_minute?
          "at #{hour.collection[0].two_digits}:#{minute.collection[0].two_digits}"
        elsif minute.frequency?
          if minute.unbounded_range?
            "every #{minute.frequency} minutes between #{hour.collection[0].two_digits}:#{minute.start.two_digits} and #{(hour.collection[0] + 1).two_digits}:00"
          elsif minute.range?
            "every #{minute.frequency} minutes between #{hour.collection[0].two_digits}:#{minute.start.two_digits} and #{hour.collection[0].two_digits}:#{minute.stop.two_digits}"
          else
            "every #{minute.frequency} minutes between #{hour_range}"
          end
        elsif minute.range?
          "every minute between #{hour.collection[0].two_digits}:#{minute.start.two_digits} and #{hour.collection[0].two_digits}:#{minute.stop.two_digits}"
        elsif minute.collection?
          "at the #{minute.collection.map{|d| d.to_i.ordinal}.to_sentence} minutes of every hour"
        end
      end
    end
  end


  class MinuteHash < CronStruct
    def every_minute?; every? && !frequency? && !range? && !collection?; end
    def single_minute?; collection? && self.collection.size == 1; end
  end

  class HourHash < CronStruct
    def every_hour?; every? && !frequency? && !range? && !collection?; end
    def single_hour?; collection? && self.collection.size == 1; end
  end
end
