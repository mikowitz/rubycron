require 'ostruct'

module Rubycron
  class CronStruct < OpenStruct
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

end
