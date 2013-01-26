require 'utility_functions'
%w{ cron_struct parser day_parser time_parser version }.each {|file| require "rubycron/#{file}" }

module Rubycron
  def self.parse(expression)
    return 'Invalid Format' if expression =~ /[^\*\d\-,\/LW#\s]/
    return 'Invalid Format' if expression.split(/\s+/).size < 5

    minute, hour, day, month, weekday, year = expression.split(/\s+/)

    time = TimeParser.parse(minute, hour)
    day = DayParser.parse(day, month, weekday)
    result = day == 'every day' && time !~ /^at \d{2}:\d{2}$/ ? "#{time}" : "#{time} #{day}"
    result.sub(/^(.)/) { $1 == 'x' ? $1 : $1.upcase}
  end
end
