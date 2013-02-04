require 'ostruct'

module Rubycron
  class CronStruct < OpenStruct
    def every?; !!every; end
    def frequency?; !!frequency; end
    def range?; !!start && !!stop; end
    def unbounded_range?; !!start; end
    def collection?; !!collection; end
    def single_element?; collection? && collection.size == 1; end

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
