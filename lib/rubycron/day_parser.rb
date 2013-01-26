module Rubycron
  class DayParser
    def initialize(day, month, weekday)
      @day, @month, @weekday = day, month, weekday
    end

    def self.parse(day, month, weekday)
      new(day, month, weekday).parse
    end

    def parse
      # simplest case
      if @day == '*' && @month == '*' && @weekday == '*'
        'every day'
      end
    end
  end
end
