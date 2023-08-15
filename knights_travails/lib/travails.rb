# frozen_string_literal: true

# node that contains a position and possible knight moves
# from such position
class MoveNode
  attr_accessor :position, :possible_moves

  def initialize(position)
    @position = position
    @possible_moves = generate_moves
  end

  def generate_moves
    
  end
end

def knight_moves(start, stop)

end
