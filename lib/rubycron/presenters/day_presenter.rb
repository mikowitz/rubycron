module Rubycron
  class DayPresenter
    def self.parse(day, month, weekday)
      day = Formatters::DayOfMonthFormatter.new(Parser.parse(day))
      month = Formatters::MonthFormatter.new(Parser.parse(month))
      weekday = Formatters::DayOfWeekFormatter.new(Parser.parse(weekday))

      case [day, month, weekday].map(&:to_s).join('')
      when 'eee' then 'every day'
      # 'on May 22nd,' not 'on the 22nd of May'
      when /^[sc]se$/ then "on #{month.s} #{day.send(day.to_s, false)}"
      when /^[sc]s.$/ then "on #{month.s} #{day.send(day.to_s, false)} and #{weekday.send(weekday.to_s)} in #{month.s}"
      # 'on the weekday(s) closest to May 22nd,' not 'on the weekday(s) closest to the 22nd of May'
      when /^wse$/ then "on the weekday closest to #{month.send(month.to_s)} #{day.s(false)}"
      when /^wce$/ then "on the weekdays closest to #{month.send(month.to_s)} #{day.s(false)}"
      when /^ws.$/ then "on the weekday closest to #{month.send(month.to_s)} #{day.s(false)} and #{weekday.send(weekday.to_s)} in #{month.send(month.to_s)}"
      when /^wc.$/ then "on the weekdays closest to #{month.send(month.to_s)} #{day.s(false)} and #{weekday.send(weekday.to_s)} in #{month.send(month.to_s)}"
      when /^e.[^e]$/ then ("on %s of %s" % [weekday.send(weekday.to_s), month.send(month.to_s)]).squeeze(' ')
      when /^..e$/ then ("%s of %s" % [day.send(day.to_s), month.send(month.to_s)]).squeeze(' ')
      else ("%s and %s of %s" % [day.send(day.to_s), weekday.send(weekday.to_s), month.send(month.to_s)]).squeeze(' ')
      end
    end
  end
end
