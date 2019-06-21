class HashSet
  attr_reader :count, :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
     if @count == num_buckets
      resize!
    end
    unless self.include?(key)
      bucket = key.hash % num_buckets
      self[bucket] << key
      @count += 1
    end
  end

  def include?(key)
     bucket = key.hash % num_buckets
    self[bucket].any? { |i| i == key}
  end

  def remove(key)
     bucket = key.hash % num_buckets
    if self.include?(key) 
      self[bucket].delete(key)
      @count -= 1
    end
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
        bucket = num.hash % num_buckets
        re_insert = num
        sub.delete(num)
        self[bucket] << num
      end
    end
    self.store
  end
end
