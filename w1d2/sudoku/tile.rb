class Tile
  attr_accessor :value
  def initialize(value)
    @value = value
    @given = value == 0 ? false : true
  end

  def to_s
    value == 0 ? " " : value.to_s
  end

  def value=(new_val)
    if @given
      puts "Given tile"
    else
      @value = new_val
    end
  end
end
