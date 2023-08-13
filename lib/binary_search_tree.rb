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
  def initialize(arr)
    @root = nil
    build_tree(arr)
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
      place_down(value) unless find(value)
    else
      @root = BinaryNode.new(value)
    end
  end

  def delete(value, start: @root)
    node, parent, left = find_node_and_parent(value, start: start)
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
    # has two children
    elsif !node.left.nil? && !node.right.nil?
      successor, successor_parent = find_inorder_successor(node)
      swap_node_values(node, successor)
      delete(value, start: successor_parent)
    end
  end

  def replace_node(parent, replacement, left)
    if left
      parent.left = replacement
    else
      parent.right = replacement
    end
  end

  # inorder successor is min of right child
  def find_inorder_successor(start_node)
    pointer = start_node.right
    prev = nil
    until pointer.left.nil?
      prev = pointer
      pointer = pointer.left
    end
    [pointer, prev]
  end

  def swap_node_values(old_node, new_node)
    temp = old_node.data
    old_node.data = new_node.data
    new_node.data = temp
  end

  def place_down(value)
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

  def inorder(&block)
    inorder_arr = inorder_traversal(@root)
    return nodes_to_data(inorder_arr) unless block_given?

    inorder_arr.each do |n|
      block.call n
    end
  end

  def preorder(&block)
    preorder_arr = preorder_traversal(@root)
    return nodes_to_data(preorder_arr) unless block_given?

    preorder_arr.each do |n|
      block.call n
    end
  end

  def postorder(&block)
    postorder_arr = postorder_traversal(@root)
    return nodes_to_data(postorder_arr) unless block_given?

    postorder_arr.each do |n|
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

  def inorder_traversal(node)
    return nil if node.nil?

    res = []
    res += inorder_traversal(node.left) unless node.left.nil?
    res.append(node)
    res += inorder_traversal(node.right) unless node.right.nil?
    res
  end

  def preorder_traversal(node)
    return nil if node.nil?

    res = []
    res.append(node)
    res += preorder_traversal(node.left) unless node.left.nil?
    res += preorder_traversal(node.right) unless node.right.nil?
    res
  end

  def postorder_traversal(node)
    return nil if node.nil?

    res = []
    res += postorder_traversal(node.left) unless node.left.nil?
    res += postorder_traversal(node.right) unless node.right.nil?
    res.append(node)
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

  # returns -1 if node does not exist
  def depth(node)
    return -1 if node.nil?

    pointer = @root
    res = 0
    until pointer == node
      return -1 if pointer.nil?

      pointer = node.data > pointer.data ? pointer.right : pointer.left
      res += 1
    end
    res
  end

  # returns -1 if node does not exist
  def height(node)
    return -1 if node.nil?
    return 0 if node.left.nil? && node.right.nil?

    res = []
    res.append(height(node.left)) if node.left
    res.append(height(node.right)) if node.right
    res.max + 1
  end

  def find(value)
    pointer = @root
    pointer = pointer.data > value ? pointer.left : pointer.right until pointer.nil? || pointer.data == value
    pointer
  end

  # returns the node, parent, and boolean for left or right
  # true for left, false for right
  def find_node_and_parent(value, start: @root)
    pointer = start
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

  def balanced?
    return true if (height(@root.left) - height(@root.right)).abs < 2

    false
  end

  def rebalance
    inorder_arr = inorder

    @root = nil
    build_tree(inorder_arr)
  end
end
