class Board

  def self.from_file(filename)
    puzzle = File.readlines(filename).map(&:chomp)
    tiles = puzzle.map do |row|
      row.chars.map(&:to_i).map { |num| Tile.new(num) }
    end
    self.new(tiles)
  end

  def initialize(grid = Array.new(9) { Array.new(9) { Tile.new(0) } } )
    @grid = grid
  end

end
