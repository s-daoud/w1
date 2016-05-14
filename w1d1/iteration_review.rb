def factors(num)
  (1..num).select{ |el| num % el == 0 }
end

def substrings(string)
  subs = []
  (string.length).times do |x|
    (string[x..-1].length).times do |y|
      subs << string[x..x + y] unless subs.include?(string[x..x + y])
    end
  end
  subs
end

def subwords(word, dictionary)
  words = substrings(word)
  words.select do |el|
    dictionary.include?(el)
  end
end

class Array
  def bubble_sort!(&prc)
    prc ||= Proc.new { |x, y| x <=> y }
    sorted = false
    until sorted
      sorted = true
      self.each_index do |idx|
        break if idx + 1 == self.length
        if prc.call(self[idx], self[idx + 1]) == 1
          self[idx], self[idx + 1] = self[idx + 1], self[idx]
          sorted = false
        end
      end
    end
    self
  end

  def bubble_sort(&prc)
    self.dup.bubble_sort!(&prc)
  end
end

p [1, 2, 3, 4, 5].shuffle.bubble_sort! { |x, y| y <=> x }
