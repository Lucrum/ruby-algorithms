# frozen_string_literal: true

# node for linked list
# pointer points to next node in list
class LinkedNode
  attr_accessor :value, :next_node

  def initialize(value, next_node = nil)
    @value = value
    @next_node = next_node
  end
end

# main class for linked list
# these methods return the node object, not value!
class LinkedList
  attr_accessor :size, :head

  def initialize
    @head = nil
    @size = 0
  end

  def append(value)
    if @head
      pointer = @head
      pointer = pointer.next_node until pointer.next_node.nil?
      new_node = LinkedNode.new(value)
      pointer.next_node = new_node
    else
      @head = LinkedNode.new(value)
    end
    @size += 1
  end

  def prepend(value)
    new_node = LinkedNode.new(value)
    new_node.next_node = @head
    @head = new_node
    @size += 1
  end

  def tail
    pointer = @head
    return nil if pointer.nil?

    pointer = pointer.next_node until pointer.next_node.nil?
    pointer
  end

  def at(value)
    pointer = @head
    ind = 0
    until ind == value
      pointer = pointer.next_node
      ind += 1
    end
    pointer
  end

  def pop
    pointer = @head
    pointer = pointer.next_node until pointer.next_node.next_node.nil?
    res = pointer.next_node.value
    pointer.next_node = nil
    @size -= 1
    res
  end

  def contains?(value)
    pointer = @head
    until pointer.nil?
      return true if pointer.value == value

      pointer = pointer.next_node
    end
    false
  end

  def find(value)
    ind = 0
    pointer = @head

    until pointer.nil? || pointer.value == value
      ind += 1
      pointer = pointer.next_node
    end
    pointer.nil? ? nil : ind
  end

  def to_s
    res = ''
    pointer = @head
    until pointer.nil?
      res += "( #{pointer.value} ) -> "
      pointer = pointer.next_node
    end
    res += 'nil'
    res
  end
end
