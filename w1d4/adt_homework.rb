class Stack
  def initialize
    @arr = []
  end

  def add(el)
    @arr << el
  end

  def remove
    @arr.pop
  end

  def show
    puts @arr
  end
end

class Queue
  def initialize
    @arr = []
  end

  def enqueue(el)
    @arr << el
  end

  def dequeue
    @arr.shift
  end

  def show
    puts @arr
  end
end

class Map
  def initialize
    @arr = []
  end

  def assign(k, v)
    remove(k) if lookup(k)
    @arr << [k, v]
  end

  def lookup(k)
    @arr.each { |pair| return pair.last if pair.first == k }
    nil
  end

  def remove(k)
    @arr.reject! { |pair| pair.first == k }
  end

  def show
    @arr.each { |pair| print "#{pair}\n" }
  end
end
