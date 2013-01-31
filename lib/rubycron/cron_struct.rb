require 'ostruct'

module Rubycron
  class CronStruct < OpenStruct
    def every?; !!self.every; end
    def frequency?; !!self.frequency; end
    def range?; !!self.start && !!self.stop; end
    def collection?; !!self.collection; end

    def unbounded_range?; !!range? && self.stop.to_i == 59; end

    def every_every?; every? && !frequency? && !range? && !collection?; end
    def single_element?; collection? && self.collection.size == 1; end

    def single_element; collection[0]; end


    def to_s
      return "E" if every_every?
      return "e" if every?
      return "F" if frequency? && unbounded_range?
      return "f" if frequency? && range?
      return "v" if frequency?
      return "u" if unbounded_range?
      return "r" if range?
      return "s" if single_element?
      return "c" if collection?
    end
  end
end
