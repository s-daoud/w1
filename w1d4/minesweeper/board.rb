require_relative 'tile'

class Board
  attr_reader :grid

  def self.empty_grid
    Array.new(9) do
      Array.new(9) { Tile.new() }
    end
  end

  def initialize(num_bombs, grid = Board.empty_grid)
    @grid = grid
    place_bombs(num_bombs)
  end

  def place_bombs(num_bombs)
    count = 0
    until count == num_bombs
      x = rand(9)
      y = rand(9)
      unless grid[x][y].is_bomb?
        grid[x][y].make_bomb
        count += 1
        (x - 1..x + 1).each do |x_val|
          (y - 1..y + 1).each do |y_val|
            next if (x_val < 0 || x_val > 8) || (y_val < 0 || y_val > 8)
            @grid[x_val][y_val].value += 1
          end
        end
      end
    end
    #add one to adjacent spaces

  end

  def find_neighbors

  end

  def render
    puts "  #{(0..8).to_a.join(" ")}"
    puts "  ___________________"
    grid.each_with_index do |row, i|
      print "#{i}| "
      row.each do |tile|
        # if !tile.is_revealed
        #   print "# "
        if tile.is_bomb?
          print "* "
        else
          print "#{tile.value} "
        end
      end
      print "\n"
    end
  end
end
