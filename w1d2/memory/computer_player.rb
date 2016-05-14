require "byebug"

class ComputerPlayer
  attr_accessor :known_cards, :matched_cards, :first_guess, :match_found

  GUESS_ARRAY = [[0, 0], [0, 1], [0, 2], [0, 3], [0, 4],
                [1, 0], [1, 1], [1, 2], [1, 3], [1, 4],
                [2, 0], [2, 1], [2, 2], [2, 3], [2, 4],
                [3, 0], [3, 1], [3, 2], [3, 3], [3, 4]]

  def initialize
    @known_cards = {}
    @first_guess = nil
    @match_found = false
    @matched_cards = []
    @switch_guess = true
  end

  def prompt
    p @known_cards
    p @matched_cards
    if @switch_guess
      p "in first"
      first_guess
    else
      p "in second"
      second_guess
    end
  end

  def random_guess
    guess = GUESS_ARRAY.sample
    while @matched_cards.include?(guess) || @known_cards.keys.include?(guess)
      guess = GUESS_ARRAY.sample
    end
    guess
  end

  def smart_guess
    @known_cards.each do |pos, value|
      @known_cards.each do |pos2, value2|
        if pos != pos2 && value == value2 && @matched_cards.none? { |el| pos == el }
          @first_guess = pos
          p "first"
          return pos
        end
      end
    end
    nil
  end

  def match_guess
    @known_cards.each do |pos, value|
      @known_cards.each do |pos2, value2|
        if pos != pos2 && value == value2 && @matched_cards.none? { |el| pos == el } && pos != @first_guess
          receive_match(pos, @first_guess) if @first_guess
          @first_guess = nil
          p "second"
          return pos
        end
      end
    end
    nil
  end

  def first_guess
    switch
    guess = smart_guess || random_guess
  end

  def second_guess
    switch
    guess = match_guess || random_guess
  end

  def switch
    @switch_guess = !@switch_guess
  end

  def receive_revealed_card(guessed_pos, card_value)
    @known_cards[guessed_pos] = card_value
  end

  def receive_match(guess_one, guess_two)
    @matched_cards << guess_one
    @matched_cards << guess_two
  end
end
