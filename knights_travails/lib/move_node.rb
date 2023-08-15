# frozen_string_literal: true

# node that contains a position and possible knight moves
# from such position
class MoveNode
  attr_accessor :position, :possible_moves, :parent

  def initialize(position, parent: nil)
    @parent = parent
    @position = position
    @possible_moves = nil
  end

  def generate_children
    res = []
    moves = generate_moves
    moves.each do |move|
      res.append(MoveNode.new(move, parent: self))
    end
    @possible_moves = res
  end

  private

  def generate_moves
    res = []
    masks = [[-2, -1], [-2, 1], [-1, 2],
             [1, 2], [-1, -2], [1, -2],
             [2, -1], [2, 1]]

    masks.each do |mask|
      new_pos = apply_mask(mask)
      res.append(new_pos) if valid_position?(new_pos)
    end
    res
  end

  def valid_position?(pos)
    return false if pos[0] > 7 || pos[1] > 7
    return false if pos[0].negative? || pos[1].negative?

    true
  end

  def apply_mask(mask)
    [@position[0] + mask[0], @position[1] + mask[1]]
  end
end