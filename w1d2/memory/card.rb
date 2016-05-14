class Card

  attr_accessor :face_value, :face_status

  def initialize(face_value)
    @face_value = face_value
    @face_status = false
  end

  def display
    if face_status
      puts face_value.to_s
    else
      puts "Card is face down"
    end
  end

  def reveal
    @face_status = true
  end

  def hide
    @face_status = false
  end

  def ==(card2)
    self.face_value == card2.face_value
  end

  def is_revealed?
    @face_status
  end
end
