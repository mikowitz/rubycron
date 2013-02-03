module Rubycron
  module TimePresenter
    def self.parse(minute, hour)
      minute = Formatters::MinuteFormatter.new(Parser.parse(minute))
      hour = Formatters::HourFormatter.new(Parser.parse(hour))

      case [minute, hour].map(&:sym).join('')
      when /[ev]e/ then minute.format
      when 're' then "every hour from xx:#{minute.start.two_digits} to xx:#{minute.stop.two_digits}"
      when 'ss' then "#{time(hour.single_element, minute.single_element)}"
      when 'sc' then "#{hour.collection.map{|hour| time(hour, minute.single_element)}.to_sentence}"
      when 'us' then "#{minute.format(false)} between #{time_range(hour.single_element, minute.start, hour.single_element, 59)}"
      when 'uc' then "#{minute.format(false)} between #{hour.collection.map{|hour| time_range(hour, minute.start, hour, 59)}.to_sentence}"
      when /c[cs]/ then "#{hour.collection.map{|hour| minute.collection.map{|minute| time(hour, minute)}}.flatten.to_sentence}"
      when /[ucsfr]r/ then ("%s of every hour between %s" % [minute.format, hour.format]).squeeze(' ')
      when /^[fr][cs]$/ then "#{minute.format(hour.collection)}"
      when /^.[rsc]$/ then ("%s between %s" % [minute.format, hour.format]).squeeze(' ')
      else ("%s of %s" % [minute.format, hour.format]).squeeze(' ')
      end
    end

    def self.time(hour, minute)
      [hour, minute].map(&:two_digits).join(':')
    end

    def self.time_range(s_hour, s_minute, e_hour, e_minute)
      "#{time(s_hour, s_minute)} and #{time(e_hour, e_minute)}"
    end
  end
end
