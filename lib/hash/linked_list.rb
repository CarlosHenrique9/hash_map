class LinkedList
  include Enumerable
  attr_accessor :head

  def initialize
    @head = nil
  end

  def is_empty?
    @head.nil?
  end

  def include?(key)
    return false if is_empty?
    return true if @head.key == key

    current = @head
    until current.next.nil?
      current = current.next
      return true if current.key == key
    end

    false
  end

  def insert(key, val)
    return @head = Node.new(key, val) if is_empty?

    current = last_node
    current.next = Node.new(key, val, nil, current)
  end

  def insert_first(key, val)
    new_node = Node.new(key, val, @head)
    @head.prev = new_node if @head
    @head = new_node
  end

  def delete(key)
    return if is_empty? || !include?(key)

    if @head.key == key
      remove_head
      return
    end

    current = @head
    until current.nil?
      if current.key == key
        delete_key(current)
        return
      end
      current = current.next
    end
  end

  def delete_first
    remove_head
  end

  def delete_last
    last = last_node
    delete_key(last)
  end

  def get(key)
    return nil if is_empty? || !include?(key)
    return @head.value if @head.key == key
    current = @head
    until current.next.nil?
      current = current.next
      return current.value if current.key == key
    end
  end


  def last
    last_node.value
  end

  def first
    is_empty? ? nil : @head.value
  end

  def size
    return 0 if is_empty?

    current = @head
    count = 1
    until current.next.nil?
      current = current.next
      count += 1
    end

    count
  end

  def each
    return if is_empty?

    current = @head
    until current.nil?
      yield(current)
      current = current.next
    end
  end

  private

  def remove_head
    val = @head.value
    @head = @head.next
    @head.prev = nil if @head
    val
  end

  def last_node
    return if is_empty?

    current = @head
    until current.next.nil?
      current = current.next
    end

    current
  end

  def delete_key(current)
    prev = current.prev
    prev.next = current.next if prev
    current.next&.prev = prev
    current.prev, current.next = nil, nil
  end
end
