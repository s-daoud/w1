require 'set'
require_relative '../00_tree_node/lib/00_tree_node'

class KnightPathFinder

  def initialize(pos)
    @pos = pos
    @visited_positions = [pos].to_set
  end

  def new_move_positions(pos)
    possible_moves = KnightPathFinder.valid_moves(pos)
    valid_moves = possible_moves.reject do |move|
      @visited_positions.include?(move)
    end
    @visited_positions += valid_moves
    valid_moves
  end

  def build_move_tree(target)
    moves_queue = [PolyTreeNode.new(@pos)]
    until moves_queue.empty?
      square = moves_queue.shift
      return square if square.value == target
      new_move_positions(square.value).each do |move|
        node = PolyTreeNode.new(move)
        node.parent = square
       moves_queue << node
      end
    end
    nil
  end

  def trace_path_back(target)
    result = build_move_tree(target)
    path = [result.value]
    parent = result.parent
    until parent.nil?
      path << parent.value
      parent = parent.parent
    end
    p path.reverse
  end


  ALL_MOVES = [[-2, -1], [-2, 1], [-1, -2], [-1, 2],
               [1, -2], [1, 2], [2, -1], [2, 1]]
  BOARD_SIZE = 16
  def self.valid_moves(pos)
    possible_moves = ALL_MOVES.map do |move|
      [move.first + pos.first, move.last + pos.last]
    end
    possible_moves.reject do |move|
      move.any? { |coord| coord < 0 || coord > BOARD_SIZE - 1}
    end
  end
end

a = KnightPathFinder.new([0,0])
a.trace_path_back([6,2])
