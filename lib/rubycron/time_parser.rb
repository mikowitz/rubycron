module Rubycron
  class TimeParser
    MINUTE_FREQUENCY = Proc.new {|frequency| "every #{frequency} minutes"}
    TIME = Proc.new {|hour, minute| [hour, minute].map(&:two_digits).join(":")}
    BETWEEN_TWO_TIMES = Proc.new {|s_hour, s_minute, e_hour, e_minute| "between #{TIME[s_hour, s_minute]} and #{TIME[e_hour, e_minute]}" }
    BETWEEN_TWO_MINUTES = Proc.new {|s_minute, e_minute| "between xx:#{s_minute.two_digits} and xx:#{e_minute.two_digits}" }

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
          ret = MINUTE_FREQUENCY[minute.frequency]
          if minute.unbounded_range?
            ret += " of every hour starting at xx:#{minute.start.two_digits}"
          elsif minute.range?
            ret += " of every hour #{BETWEEN_TWO_MINUTES[minute.start, minute.stop]}"
          end
          ret
        elsif minute.range?
          "every minute of every hour #{BETWEEN_TWO_MINUTES[minute.start, minute.stop]}"
        elsif minute.collection?
          "at the #{minute.collection.map{|d| d.to_i.ordinal}.to_sentence} minutes of every hour"
        end
      elsif hour.single_hour?
        hour_range = BETWEEN_TWO_TIMES[hour.collection.first, 0, hour.collection.first.to_i + 1, 0]
        if minute.every_minute?
          "every minute #{hour_range}"
        elsif minute.single_minute?
          "at #{hour.collection[0].two_digits}:#{minute.collection[0].two_digits}"
        elsif minute.frequency?
          freq = MINUTE_FREQUENCY[minute.frequency]
          if minute.unbounded_range?
            "#{freq} #{BETWEEN_TWO_TIMES[hour.collection.first, minute.start, hour.collection.first.to_i + 1, 0]}"
          elsif minute.range?
            "#{freq} #{BETWEEN_TWO_TIMES[hour.collection.first, minute.start, hour.collection.first, minute.stop]}"
          else
            "#{freq} #{hour_range}"
          end
        elsif minute.range?
          "every minute #{BETWEEN_TWO_TIMES[hour.collection.first, minute.start, hour.collection.first, minute.stop]}"
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
