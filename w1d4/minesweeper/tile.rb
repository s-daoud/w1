class Tile
  attr_accessor :has_bomb, :value, :is_revealed, :flag

  def initialize()
    @value = 0
    @flag, @is_revealed, @has_bomb = false, false, false
  end

  # def neighbors(all_neighbors)
  #   # all_neighbors
  # end
  #
  # def neighbor_bomb_count(tile)
  #   # count = 0
  #   # tile.neighbors.each do |el|
  #   #   count += 1 if el.has_bomb
  #   # end
  #   # count
  # end

  def make_bomb
    @has_bomb = true
  end

  def is_bomb?
    has_bomb
  end

  def reveal
    @is_revealed = true
  end

  def toggle_flag
    @flag = !@flag
  end
end
