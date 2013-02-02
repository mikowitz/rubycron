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

      case [minute, hour].map(&:to_s).join('')
      when 'ee' then 'every minute'
      when 'ef' then "every minute of every #{hour.frequency.ordinal} hour between #{hour.within_range}"
      when 'ev' then "every minute of every #{hour.frequency.ordinal} hour"
      when 'er' then "every minute between #{hour.within_range}"
      when 'es' then "every minute between #{hour.within_collection}"
      when 'ec' then "every minute between #{hour.within_collection}"

      when 'fe' then "#{freq(minute)} #{minute.range} every hour"
      when 'ff' then "#{freq(minute)} #{minute.range} every #{hour.frequency.ordinal} hour between #{hour.within_range}"
      when 'fv' then "#{freq(minute)} #{minute.range} every #{hour.frequency.ordinal} hour"
      when 'fr' then "#{freq(minute)} #{minute.range} every hour between #{hour.within_range}"
      when 'fs' then "#{freq(minute)} #{minute.range(hour.single_element.two_digits)}"
      when 'fc' then "#{freq(minute)} between #{hour.collection.map{|hour| "#{hour.two_digits}:#{minute.start.two_digits} and #{hour.two_digits}:#{minute.stop.two_digits}" }.to_sentence}"

      when 've' then freq(minute)
      when 'vf' then "#{freq(minute)} of every #{hour.frequency.ordinal} hour between #{hour.within_range}"
      when 'vv' then "#{freq(minute)} of every #{hour.frequency.ordinal} hour"
      when 'vr' then "#{freq(minute)} of every hour between #{hour.within_range}"
      when 'vs' then "#{freq(minute)} between #{hour.within_collection}"
      when 'vc' then "#{freq(minute)} between #{hour.within_collection}"

      when 're' then "every hour #{minute.range}"
      when 'rf' then "every minute #{minute.range} every #{hour.frequency.ordinal} hour between #{hour.within_range}"
      when 'rv' then "#{minute.range} every #{hour.frequency.ordinal} hour"
      when 'rr' then "every minute #{minute.range} every hour between #{hour.within_range}"
      when 'rs' then "every minute #{minute.range(hour.single_element.two_digits)}"
      when 'rc' then "every minute between #{hour.collection.map{|hour| "#{hour.two_digits}:#{minute.start.two_digits} and #{hour.two_digits}:#{minute.stop.two_digits}" }.to_sentence}"

      when 'se' then "the #{minute.ordinal} of every hour"
      when 'sf' then "the #{minute.ordinal} of every #{hour.frequency.ordinal} hour between #{hour.within_range}"
      when 'sv' then "the #{minute.ordinal} of every #{hour.frequency.ordinal} hour"
      when 'sr' then "the #{minute.ordinal} of every hour between #{hour.within_range}"
      when 'ss' then time(hour.single_element, minute.single_element)
      when 'sc' then hour.collection.map{|hour| time(hour, minute.single_element)}.to_sentence

      when 'ce' then "#{minute.collection_ordinals} of every hour"
      when 'cf' then "#{minute.collection_ordinals} of every #{hour.frequency.ordinal} hour between #{hour.within_range}"
      when 'cv' then "#{minute.collection_ordinals} of every #{hour.frequency.ordinal} hour"
      when 'cr' then "#{minute.collection_ordinals} of every hour between #{hour.within_range}"
      when 'cs' then minute.collection.map{|minute| time(hour.single_element, minute)}.to_sentence
      when 'cc' then hour.collection.map{|hour| minute.collection.map{|minute| time(hour, minute)}}.flatten.to_sentence
      end
    end

    def time(hour, minute)
      [hour, minute].map(&:two_digits).join(':')
    end

    def freq(time_object)
      "every #{time_object.frequency} #{time_object.name}s"
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
end
