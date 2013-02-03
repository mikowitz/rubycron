require 'ostruct'

module Rubycron
  class CronStruct < OpenStruct
    def every?; !!self.every; end
    def frequency?; !!self.frequency; end
    def range?; !!self.start && !!self.stop; end
    def unbounded_range?; !!self.start; end
    def collection?; !!self.collection; end
    def single_element?; collection? && self.collection.size == 1; end

    def single_element; collection[0]; end

    def sym
      return "e" if every?
      return "f" if frequency? && range?
      return "u" if frequency? && unbounded_range?
      return "v" if frequency?
      return "r" if range?
      return "s" if single_element?
      return "c" if collection?
    end

    def format(*args)
      send sym, *args
    end
  end
end
