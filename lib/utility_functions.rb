class Array
  def to_sentence
    if self.size == 2
      self.join(' and ')
    else
      self[0..-2].join(', ') + " and #{self.last}"
    end
  end
end

class String
  def two_digits
    self.rjust(2, '0')
  end
end

class Numeric
  def two_digits
    self.to_s.two_digits
  end

  def ordinal
    return "#{self}th" if self.between?(10, 20)
    case self. % 10
    when 1 then "#{self}st"
    when 2 then "#{self}nd"
    when 3 then "#{self}rd"
    else        "#{self}th"
    end
  end
end
