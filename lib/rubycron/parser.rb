module Rubycron
  class Parser
    def self.parse(element)
      @element = element
      case @element
      when '*' then { every: true }
      when /^l$/i then { last: true }
      when /(\d|\w{3})l$/i
        @element = @element.sub(/l$/i, '')
        { last: true, collection: parse_collection }
      when /.*#\d$/
        @element, nth_week = @element.scan(/(.*)#(\d)$/)[0]
        { nth_week: nth_week, collection: parse_collection }
      when /\d+w$/i
        @element = @element.sub(/w$/i, '')
        { nearest: true, collection: parse_collection }
      when /\//
        start, frequency = @element.scan(/(.*)\/(.*)/)[0]
        case start
        when '*'
          { frequency: frequency }
        when /^\d+$/ #single number
          { frequency: frequency, start: start }
        when /^\d+-\d+$/
          range_start, range_end = *start.scan(/(\d+)-(\d+)/)[0]
          { frequency: frequency, start: range_start, stop: range_end }
        end
      when /^\d+-\d+$/
        range_start, range_end = *@element.scan(/(\d+)-(\d+)/)[0]
        { start: range_start, stop: range_end }
      else { collection: parse_collection }
      end
    end

    def self.parse_collection
      parts = @element.split(',')
      res = []
      parts.each do |part|
        if part =~ /\-/
          range = part.scan(/(\d+)-(\d+)/)[0]
          res += Array(range[0].to_i..range[1].to_i)
        else
          res << part
        end
      end
      res
    end
  end
end
