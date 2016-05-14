require_relative "board.rb"
require_relative "computer_player.rb"
require_relative "human_player.rb"
require_relative "card.rb"

class Game
  attr_accessor :board, :previous_guess
  def initialize(player)
    @board = Board.new
    @player = player
  end

  def play
    until over?
      render
      #sleep(1)
      #system("clear")
      guess = @player.prompt
      make_guess(guess)
    end
    puts "You win!"
  end

  def over?
    board.won?
  end

  def render
    board.render
    print "\n"
  end

  def make_guess(guessed_pos)
    p guessed_pos
    guess_card = board.grid[guessed_pos[0].to_i][guessed_pos[-1].to_i]

    @player.receive_revealed_card(guessed_pos, guess_card.face_value)

    if previous_guess.nil?
      @previous_guess = guessed_pos
      guess_card.reveal
    else
      previous_card = board.grid[previous_guess[0].to_i][previous_guess[-1].to_i]
      if guess_card == previous_card
        guess_card.reveal
        previous_card.reveal
      else
        puts "#{guess_card.face_value} doesn't match"
        guess_card.hide
        previous_card.hide
      end
      @previous_guess = nil
    end
  end
end

Game.new(ComputerPlayer.new).play
