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
      when /[ev]e/ then minute.send(minute.to_s)
      when 're' then "every hour from xx:#{minute.start.two_digits} to xx:#{minute.stop.two_digits}"
      when 'ss' then "#{time(hour.single_element, minute.single_element)}"
      when 'sc' then "#{hour.collection.map{|hour| time(hour, minute.single_element)}.to_sentence}"
      when /c[cs]/ then "#{hour.collection.map{|hour| minute.collection.map{|minute| time(hour, minute)}}.flatten.to_sentence}"
      when /[csfr]r/ then ("%s of every hour between %s" % [minute.send(minute.to_s), hour.send(hour.to_s)]).squeeze(' ')
      when /^[fr][cs]$/ then "#{minute.send(minute.to_s, hour.collection)}"
      when /^.[rsc]$/ then ("%s between %s" % [minute.send(minute.to_s), hour.send(hour.to_s)]).squeeze(' ')
      else ("%s of %s" % [minute.send(minute.to_s), hour.send(hour.to_s)]).squeeze(' ')
      end
    end

    def time(hour, minute)
      [hour, minute].map(&:two_digits).join(':')
    end

    def freq(time_object)
      "every #{time_object.frequency} #{time_object.name}s"
    end
  end
end
