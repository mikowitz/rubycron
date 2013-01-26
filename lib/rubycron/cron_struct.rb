require 'ostruct'

module Rubycron
  class CronStruct < OpenStruct
    def every?; !!self.every; end
    def frequency?; !!self.frequency; end
    def range?; !!self.start && !!self.stop; end
    def collection?; !!self.collection; end

    def unbounded_range?; !!range? && self.stop.to_i == 59; end
  end
end
