module Rubycron
  class Parser
    def initialize(element)
      @element = element
    end

    def parse
      if @element == '*'
        { every: true }
      elsif @element =~ /\//
        start, frequency = @element.scan(/(.*)\/(.*)/)[0]
        if start == '*'
          { every: true, frequency: frequency }
        elsif start =~ /^\d+$/ #single number
          { every: true, frequency: frequency, start: start, stop: 59 }
        elsif start =~ /^\d+-\d+$/
          range_start, range_end = *start.scan(/(\d+)-(\d+)/)[0]
          { every: true, frequency: frequency, start: range_start, stop: range_end }
        end
      else
        if @element =~ /,/
          { every: false, collection: parse_collection }
        elsif @element =~ /^\d+-\d+$/
          range_start, range_end = *@element.scan(/(\d+)-(\d+)/)[0]
          { every: false, start: range_start, stop: range_end }
        else
          { every: false, collection: parse_collection }
        end
      end
    end

    def parse_collection
      parts = @element.split(',')
      res = []
      parts.each do |part|
        if part =~ /-/
          range = part.scan(/(\d+)-(\d+)/)[0]
          res += Array(range[0].to_i..range[1].to_i)
        else
          res << part.to_i
        end
      end
      res
    end
  end
end
