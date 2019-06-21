require_relative 'p04_linked_list'
require "byebug"
class HashMap
  include Enumerable
  attr_accessor :count ,:store 

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    current_bucket = @store[bucket(key)]
    current_bucket.include?(key)
  end

  def set(key, val)
    current_bucket = @store[bucket(key)]
    if current_bucket.include?(key)
      current_bucket.update(key,val)
    else
      current_bucket.append(key, val)
      @count += 1
    end
  end

  def get(key)
    current_bucket = @store[bucket(key)]
    if current_bucket.include?(key)
      current_bucket.each do |node|
        return node.val if node.key == key 
      end
    end
    nil
  end

  def delete(key)
    current_bucket = @store[bucket(key)]
    if current_bucket.include?(key)
      current_bucket.each do |node|
        node.remove if node.key == key 
        @count -= 1
        break
      end
    end
    nil
  end

  def each
    @store.each do |bucket|
      bucket.each do |node|
        yield(node.key, node.val)
      end
    end
    self
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  
  private

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets + @store.length)
    self.each do |list|
      list.each do |node|
        no
      end
    end
  end
  # newsize = Array.new(nulm_buckets) {[]}
  #   self.store.concat(newsize)
  #   self.store.each do |sub|
  #     sub.each do |num|
  #       bucket = num.hash % num_buckets
  #       re_insert = num
  #       sub.delete(num)
  #       self[bucket] << num
  #     end
  #   end
  #   self.store

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    bucket = key.hash % num_buckets
  end
end


