require_relative "00_tree_node.rb"
require "set"

class KnightPathFinder
  ALL_MOVES = [[-2, 1], [-2, -1], [-1, 2], [-1, -2],
               [1, 2], [1, -2], [2, 1], [2, -1]]

  def initialize(starting_pos)
    @visited_positions = Set.new
    @root_node = PolyTreeNode.new(starting_pos)
    self.build_move_tree
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

  def new_move_positions(starting_pos)
    self.class.valid_moves(starting_pos).reject do |pos|
      @visited_positions.include?(pos)
    end
  end

  def build_move_tree
    queue = [@root_node]
    until queue.empty?
      node = queue.shift
      new_move_positions(node.value).each do |child_pos|
        child_node = PolyTreeNode.new(child_pos)
        child_node.parent = node
        queue.push(child_node)
        @visited_positions.add(child_pos)
      end
    end
  end

  def find_path(end_pos)
    trace_path_back(@root_node.bfs(end_pos))
  end

  def trace_path_back(node)
    return [node.value] if node == @root_node
    trace_path_back(node.parent) << node.value
  end
end
