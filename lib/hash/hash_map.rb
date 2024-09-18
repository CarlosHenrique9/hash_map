class HashMap
  attr_accessor :capacity, :buckets, :size, :collitions

  include Enumerable

  def keys
    result = []
    each { |node| result << node.key }
    result
  end

  def values
    result = []
    each { |node| result << node.value }
    result
  end

  def entries
    result = []
    each { |node| result << [node.key, node.value] }
    result
  end


  def initialize
    @capacity = 5
    @buckets = Array.new(@capacity) { LinkedList.new }
    @size = 0
    @collitions = 0
  end

  def is_empty?
    @size == 0
  end

  def insert(key, val)
    if @size == @capacity
      rehash
      insert(key, val)
    else
      index = get_bucket_index(key)
      @collitions += 1 if !@buckets[index].is_empty?
      @buckets[index].insert(key, val)
      @size += 1
    end
  end

  def get(key)
    return nil if is_empty?
    @buckets[get_bucket_index(key)].get(key)
  end

  def remove(key)
    return nil if is_empty?
    @buckets[get_bucket_index(key)].delete(key)
    @collitions -= 1 if @buckets[get_bucket_index(key)].size <= 1
    @size -= 1
  end

  def include?(key)
    return false if is_empty?
    @buckets[get_bucket_index(key)].include?(key)
  end

  def each
    return if is_empty?
    @buckets.each do |bucket|
      current = bucket.head
      if current
        bucket.each do |node|
          yield(node) if defined?(yield)
        end
      end
    end
  end

  def clear
    @buckets = Array.new(@capacity) { LinkedList.new }
    @size = 0
    @collitions = 0
  end

  private

  def get_bucket_index(key)
    hash(key) % @capacity
  end

  def hash(key)
    key = "#{key}#{key.class}"
    hash_code = 0

    key.each_char { |char| hash_code = 31 * hash_code + char.ord }
    hash_code
  end

  def rehash
    @capacity *= 2
    @collitions = 0
    rehash_buckets = Array.new(@capacity) { LinkedList.new }
    @buckets.each do |bucket|
      current = bucket.head
      if current
        insert_rehashed(current, rehash_buckets)
        until current.next.nil?
          current = current.next
          insert_rehashed(current, rehash_buckets)
        end
      end
    end
    @buckets = rehash_buckets
  end

  def insert_rehashed(current, rehash_buckets)
    index = get_bucket_index(current.key)
    @collitions += 1 if !rehash_buckets[index].is_empty?
    rehash_buckets[index].insert(current.key, current.value)
  end
end
