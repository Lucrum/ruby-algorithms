# frozen_string_literal: true

require_relative 'utils'

# node for binary trees. left and right pointer
class BinaryNode
  attr_accessor :left, :right, :data

  def initialize(value)
    @data = value
    @left = nil
    @right = nil
  end
end

# binary tree struct
class Tree
  def initialize
    @root = nil
  end

  def build_tree(arr)
    build_tree_helper(arr.uniq.sort)
  end

  def build_tree_helper(arr)
    case arr
    in nil then return
    in [x] then insert x
    else
      insert(arr[arr.size / 2])
      arr.delete_at(arr.size / 2)
      left, right = split_array_half(arr)
      build_tree_helper(left)
      build_tree_helper(right)
    end
  end

  def insert(value)
    if @root
      search_down(value) unless find(value)
    else
      @root = BinaryNode.new(value)
    end
  end

  # TODO delete nodes with two children
  def delete(value)
    node, parent, left = find_node_and_parent(value)
    return unless node

    # leaf node
    if node.left.nil? && node.right.nil?
      replace_node(parent, nil, left)
    # has a left child
    elsif !node.left.nil? && node.right.nil?
      replace_node(parent, node.left, left)
    # has a right child
    elsif node.left.nil? && !node.right.nil?
      replace_node(parent, node.right, left)
    end
    # has two children
  end

  def replace_node(parent, replacement, left)
    if left
      parent.left = replacement
    else
      parent.right = replacement
    end
  end

  def search_down(value)
    pointer = @root
    prev = nil
    left = true
    until pointer.nil?
      prev = pointer
      left = pointer.data > value
      pointer = pointer.data > value ? pointer.left : pointer.right
    end
    new_node = BinaryNode.new(value)
    left ? prev.left = new_node : prev.right = new_node
  end

  def level_order(&block)
    breadth_arr = breadth_first
    return nodes_to_data(breadth_arr) unless block_given?

    breadth_arr.each do |n|
      block.call n
    end
  end

  def breadth_first
    return nil if @root.nil?

    queue = [@root.left, @root.right]
    res = [@root]
    until queue.empty?
      pointer = queue.shift
      queue.append(pointer.left) unless pointer.left.nil?
      queue.append(pointer.right) unless pointer.right.nil?
      res.append(pointer)
    end
    res
  end

  def nodes_to_data(arr)
    return nil if arr.empty?

    res = []
    arr.each do |x|
      res.append(x.data)
    end
    res
  end

  def depth(node)
    pointer = @root
    res = 0
    until pointer == node
      return nil if pointer.nil?

      pointer = node.data > pointer.data ? pointer.right : pointer.left
      res += 1
    end
    res
  end

  def find(value)
    pointer = @root
    pointer = pointer.data > value ? pointer.left : pointer.right until pointer.nil? || pointer.data == value
    pointer
  end

  # returns the node, parent, and boolean for left or right
  # true for left, false for right
  def find_node_and_parent(value)
    pointer = @root
    prev = nil
    left = false
    until pointer.nil? || pointer.data == value
      prev = pointer
      if pointer.data > value
        pointer = pointer.left
        left = true
      else
        pointer = pointer.right
        left = false
      end
    end
    pointer.nil? ? nil : [pointer, prev, left]
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

test_tree = Tree.new
test_tree.build_tree([7, 5, 2, 4, 1, 3, 6])

# test_tree.pretty_print
# p test_tree.level_order
test_tree.pretty_print
# p test_tree.depth(test_tree.find(7))
puts '--------------'
test_tree.delete(5)
test_tree.pretty_print
puts '--------------'
test_tree.delete(6)
test_tree.pretty_print
