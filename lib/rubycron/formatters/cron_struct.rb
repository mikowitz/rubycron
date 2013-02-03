require 'ostruct'

module Rubycron
  class CronStruct < OpenStruct
    MONTHS = %w{ January February March April May June July August September October November December }
    CRON_MONTHS = %w{ jan feb mar apr may jun jul aug sep oct nov dec }
    DAYS = %w{ Sunday Monday Tuesday Wednesday Thursday Friday Saturday }
    CRON_DAYS = %w{ sun mon tue wed thu fri sat }
    def every?; !!self.every; end
    def frequency?; !!self.frequency; end
    def range?; !!self.start; end
    def collection?; !!self.collection; end

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
