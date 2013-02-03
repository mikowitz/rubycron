module Rubycron
  class YearPresenter
    def self.parse(year)
      year = Formatters::YearFormatter.new(Parser.parse(year))
      year.format
    end
  end
end
