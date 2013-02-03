require 'utility_functions'
%w{ cron_struct minute_formatter hour_formatter day_of_month_formatter month_formatter day_of_week_formatter }.each {|formatter| require "rubycron/formatters/#{formatter}" }
%w{ parser presenters/day_presenter presenters/time_presenter version }.each {|file| require "rubycron/#{file}" }

module Rubycron
  def self.parse(expression)
    return 'Invalid Format' if expression.split(/\s+/).size < 5

    @minute, @hour, @day, @month, @weekday, @year = expression.split(/\s+/)
    return 'Invalid Format' unless valid?

    time = TimePresenter.parse(@minute, @hour)
    day = DayPresenter.parse(@day, @month, @weekday)
    result = "#{time} #{day}"
    result.sub(/^(.)/) { $1 == 'x' ? $1 : $1.upcase}
  end

  def self.valid?
    @minute =~ /^[\*\/,\-\d]+$/ &&
    @hour =~ /^[\*\/,\-\d]+$/ &&
    @day =~ /^[\*\/,\-\?LW\d]+$/ &&
    @month =~ /^[\*\/,\-\djanfebmrpyjulgsoctv]+$/i &&
    @weekday =~ /^[\*\/,\-\?\dsunmotewdhfriaL#]+$/i &&
    (@year.nil? || @year  =~ /^[\*\/,\-\d]*$/)
  end
end
