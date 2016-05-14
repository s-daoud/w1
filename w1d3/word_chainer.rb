require 'set'

class WordChainer

  def initialize(dictionary_file_name)
    words = File.readlines(dictionary_file_name).map(&:chomp)
    @dictionary = Set.new(words)
  end

  def adjacent_words(word)
    possible_adjacent_words(word).select { |word| @dictionary.include?(word) }
  end

  def run(source, target)
    beginning_time = Time.now
    @current_words = [source]
    @all_seen_words = {source => nil}
    until @all_seen_words.has_key?(target) || @current_words.empty?
      explore_current_words(target)
    end
    p build_path(target)
    end_time = Time.now
    puts "Time elapsed #{(end_time - beginning_time)} seconds"
  end

  def build_path(target)
    path = []
    previous_word = @all_seen_words[target]
    until previous_word.nil?
      path.unshift(previous_word)
      previous_word = @all_seen_words[previous_word]
    end
    path.empty? ? "No path" : path << target
  end

  def explore_current_words(target)
    new_current_words = []
    @current_words.each do |word|
      adjacent_words(word).each do |adj_word|
        next if @all_seen_words.has_key?(adj_word)
        new_current_words << adj_word
        @all_seen_words[adj_word] = word
        break if adj_word == target
      end
      break if @all_seen_words.has_key?(target)
    end
    new_current_words.each { |word| p "new word: #{word}, source: #{@all_seen_words[word]}"}
    @current_words = new_current_words
  end

  def is_adjacent?(word_one, word_two)
    return false unless word_one.length == word_two.length
    differences = letter_arrangement(word_one).select do |idx, letter|
      letter_arrangement(word_two)[idx] != letter
    end
    differences.length == 1
  end

  def letter_arrangement(word)
    letters = {}
    word.chars.each_with_index { |char, i| letters[i] = char }
    letters
  end

  def possible_adjacent_words(word)
    possibilities = []
    (word.length).times do |i|
      copy = word.split('')
      ('a'..'z').to_a.each do |letter|
        copy[i] = letter
        possibilities << copy.join
      end
    end
    possibilities
  end
end

WordChainer.new("dictionary.txt").run("market", "killer")
