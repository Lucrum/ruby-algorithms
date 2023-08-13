# frozen_string_literal: true

require_relative '../lib/binary_search_tree'

test_tree = Tree.new(Array.new(15) { rand(1..100) })
puts test_tree.balanced?
test_tree.insert(256)
test_tree.insert(128)
test_tree.insert(231)
test_tree.insert(102)
test_tree.insert(188)
puts test_tree.balanced?
test_tree.rebalance
puts test_tree.balanced?
puts "#{test_tree.level_order}\n"
print "#{test_tree.preorder}\n"
print "#{test_tree.postorder}\n"
print "#{test_tree.inorder}\n"
