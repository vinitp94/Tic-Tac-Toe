require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    return true if board.won? && board.winner != evaluator

    if evaluator == next_mover_mark
      children.all? do |child|
        child.losing_node?(evaluator)
      end
    else
      children.any? do |child|
        child.losing_node?(evaluator)
      end
    end
  end

  def winning_node?(evaluator)
    losing_node?(evaluator) && evaluator == next_mover_mark
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    empty_spaces = []
    board.rows.each_with_index do |row, i|
      row.each_with_index do |_, j|
        if board.empty?([i, j])
          new_board = board.dup
          new_board[[i, j]] = next_mover_mark
          new_next_mover_mark = next_mover_mark == :x ? :o : :x
          empty_spaces << TicTacToeNode.new(new_board,
                                            new_next_mover_mark, [i, j])
        end
      end
    end

    empty_spaces
  end
end
