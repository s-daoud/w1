class Game
  attr_accessor :current_player

  def initialize(player_one, player_two)
    @player_one = player_one
    @player_two = player_two
    @fragment = ""
    @current_player = player_one
    set_dictionary
  end

  def set_dictionary
    @dictionary = File.readlines("ghost-dictionary.txt").map(&:chomp)
  end

  def valid_play?(string)
    return false unless string =~ /[A-Za-z]/ && string.length == 1
    new_word = @fragment + string.downcase
    location = new_word.length - 1
    @dictionary.each do |word|
      return true if word[0..location] == new_word
    end
    false
  end

  def lose?
    @dictionary.include?(@fragment)
  end

  def take_turn(current_player)
    puts "#{current_player.name}, please enter a letter."
    input = gets.chomp
    if valid_play?(input)
      @fragment += input
    else
      puts "That is an invalid play!"
      take_turn(current_player)
    end
  end

  def display_frag
    puts "Current word: #{@fragment}"
  end

  def display_score
    ghost = " GHOST"
    puts "#{@player_one.name}:#{ghost[0..@player_one.losses]}"
    puts "#{@player_two.name}:#{ghost[0..@player_two.losses]}"
  end

  def play_game
    until current_player.losses == 5
      while true
        take_turn(current_player)
        display_frag
        break if lose?
        switch_players
      end
      puts "#{current_player.name} loses a round!"
      current_player.losses += 1
      display_score
      @fragment = ""
    end
    puts "#{current_player.name} loses the game!"
  end

  def switch_players
    @current_player = @current_player == @player_one ? @player_two : @player_one
  end
end

class Player
  attr_reader :name
  attr_accessor :losses
  def initialize(name)
    @name = name
    @losses = 0
  end
end

new_game = Game.new(Player.new("John"), Player.new("Jane"))
new_game.play_game




total_player_names = []
puts "How many players are playing?"
num_of_players = gets.chomp

num_of_players.times do |x|
  puts "Enter player#{x}'s name!"
  name = gets.chomp
  total_player_names << name
end
new_game = Game.new(total_player_names.map { |el| Player.new(el) }
