require_relative "00_tree_node.rb"

class KnightPathFinder
  ALL_MOVES = [[-2, 1], [-2, -1], [-1, 2], [-1, -2],
               [1, 2], [1, -2], [2, 1], [2, -1]]

  def initialize(starting_pos)
    @starting_pos = starting_pos
    @move_tree = self.class.build_move_tree
  end

  def self.in_bounds?(pos)
    pos[0] >= 0 && pos[0] < 8 && pos[1] >= 0 && pos[1] < 8
  end

  def self.valid_moves(starting_pos)
    row, col = starting_pos

    moves = []
    ALL_MOVES.each do |move|
      pot_move = [move[0] + row, move[1] + col]
      moves << pot_move if in_bounds?(pot_move)
    end
    moves
  end
end
