class Board
  attr_accessor :grid
  def initialize
    @grid = Array.new(4) { Array.new(5) }
    populate
  end

  def populate
    grid_array = [[0, 0], [0, 1], [0, 2], [0, 3], [0, 4],
                  [1, 0], [1, 1], [1, 2], [1, 3], [1, 4],
                  [2, 0], [2, 1], [2, 2], [2, 3], [2, 4],
                  [3, 0], [3, 1], [3, 2], [3, 3], [3, 4]]
    card_array = (0..9).to_a
    10.times do
      value = card_array.sample
      card_array.delete(value)
      2.times do
        temp_card = Card.new (value)
        temp_pos = grid_array.sample
        grid_array.delete(temp_pos)
        @grid[temp_pos.first][temp_pos.last] = temp_card
      end
    end
  end

  def render
    @grid.each do |row|
      row.each do |card|
        if card.face_status
          print card.face_value.to_s + " "
        else
          print "* "
        end
      end
      print "\n"
    end
  end

  def won?
    @grid.flatten.all? {|card| card.face_status}
  end

  def reveal(guessed_pos)
    temp_card = @grid[guessed_pos.first][guessed_pos.last]
    temp_card.display
  end
end
