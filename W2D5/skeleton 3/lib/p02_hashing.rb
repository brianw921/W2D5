
class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    combine_hash = 0
    self.each.with_index do |el,idx|
      combine_hash += el.to_i.hash * idx 
    end
    combine_hash
  end
end

class String
  def hash
    combine_hash = 0
    self.each_char.with_index do |el,idx|
      combine_hash += el.ord.hash * idx
    end
    combine_hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    0
  end
end
