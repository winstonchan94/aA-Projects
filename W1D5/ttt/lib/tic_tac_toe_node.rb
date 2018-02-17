require_relative 'tic_tac_toe'

class TicTacToeNode

  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    moves = []

    board.rows.each_index do |r_index|
      board.rows[r_index].each_index do |c_index|
        pos = [r_index, c_index]
        next unless board.empty?(pos)
        new_board = board.dup
        new_board[pos] = next_mover_mark
        current_mark = next_mover_mark == :x ? :o : :x
        move_node = self.class.new(new_board, current_mark, pos)
        moves << move_node
      end
    end
    moves
  end
end
