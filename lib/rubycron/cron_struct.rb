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

    def collection_ordinals
      "the #{collection.map(&:ordinal).to_sentence} #{self.name}s"
    end

    def to_s
      return "e" if every_every?
      return "f" if frequency? && range?
      return "v" if frequency?
      return "r" if range?
      return "s" if single_element?
      return "c" if collection?
    end
  end
end
