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
      when /c[cs]/ then "#{hour.collection.map{|hour| minute.collection.map{|minute| time(hour, minute)}}.flatten.to_sentence}"
      when /[csfr]r/ then ("%s of every hour between %s" % [minute.format, hour.format]).squeeze(' ')
      when /^[fr][cs]$/ then "#{minute.format(hour.collection)}"
      when /^.[rsc]$/ then ("%s between %s" % [minute.format, hour.format]).squeeze(' ')
      else ("%s of %s" % [minute.format, hour.format]).squeeze(' ')
      end
    end

    def self.time(hour, minute)
      [hour, minute].map(&:two_digits).join(':')
    end
  end
end
