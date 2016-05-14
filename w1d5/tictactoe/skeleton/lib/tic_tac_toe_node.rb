require_relative 'tic_tac_toe'

class TicTacToeNode
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @next_mover_mark = next_mover_mark
    @board = board.dup
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    return true if @board.over? && @board.winner == oponnent
    return false if @board.over? && (@board.tied? || @board.winner == us)

    return true if our_turn && children.all? { all moves are losers}

    return true if oponents_turn && children.any? { we lose }
  end

  def winning_node?(evaluator)
    
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    @board.rows.each_with_index do |row_array, row|
      row_array.each_with_index do |space, col|
        pos = [row, col]
        if @board[pos].empty?
          @board[pos] = next_mover_mark
          TicTacToeNode.new(@board, !next_mover_mark, pos)
        end
      end
    end
  end
end
