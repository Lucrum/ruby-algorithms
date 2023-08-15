# frozen_string_literal: true

require_relative 'move_node'

def knight_moves(start, stop)
  queue = []
  pointer = MoveNode.new(start)

  until pointer.position == stop
    pointer.generate_children
    queue += pointer.possible_moves
    pointer = queue.shift
  end
  back_track(pointer, start)
end

def back_track(end_node, start_pos)
  pointer = end_node
  res = []
  until pointer.position == start_pos
    res.append(pointer.position)
    pointer = pointer.parent
  end
  res.append(start_pos)
  res.reverse
end

def output_path(path)
  puts "You made it in #{path.size - 1} moves! Here's your path:"
  path.each do |x|
    print "#{x}\n"
  end
end

output_path(knight_moves([3, 3], [4, 3]))
