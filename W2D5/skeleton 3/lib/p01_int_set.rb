require "byebug"
class MaxIntSet
  attr_accessor :store
  def initialize(max)
    @store = Array.new(max, false)
  end

  def insert(num)
    raise "Out of bounds" if num > @store.length || num < 0
    # if self.include?(num) == false 
    #   @store[num] = true
    # end
    self.store[num] = true
  end

  def remove(num)
   
    a = self.include?(num)
    if a
      @store[num] = false
    end
  end

  def include?(num)
    return true if @store[num] == true
    false
  end

  private

  def is_valid?(num)
  end

  def validate!(num)
  end
end


class IntSet
  attr_accessor :store
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) {[]}
  end

  def insert(num)
    bucket = num % num_buckets
    self[bucket] << num
  end

  def remove(num)
    bucket = num % num_buckets
    if self.include?(num) 
      self[bucket].delete(num)
    end
  end

  def include?(num)
    bucket = num % num_buckets
    self[bucket].any? { |i| i == num} #return true /false 
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    self.store[num]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count, :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    if @count == num_buckets
      resize!
    end
    unless self.include?(num)
      bucket = num % num_buckets
      self[bucket] << num
      @count += 1
    end
  end

  def remove(num)
     bucket = num % num_buckets
    if self.include?(num) 
      self[bucket].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    bucket = num % num_buckets
    self[bucket].any? { |i| i == num} #return true /false 
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
     self.store[num]
  end

  def num_buckets
    @store.length
  end

  def resize!
    newsize = Array.new(num_buckets) {[]}
    self.store.concat(newsize)
    self.store.each do |sub|
      sub.each do |num|
        bucket = num % num_buckets
        re_insert = num
        sub.delete(num)
        self[bucket] << num
      end
    end
    self.store
  end
end
