class Array

  def my_each
    idx = 0
    while idx < self.length
      yield(self[idx])
      idx += 1
    end
    self
  end

  def my_select
    blank = []
    self.my_each { |el| blank << el if yield(el) }
    blank
  end

  def my_reject
    blank = []
    self.my_each { |el| blank << el unless yield(el) }
    blank
  end

  def my_all?
    self.my_each do |el|
      return false if yield(el) == false
    end
    true
  end

  def my_any?
    self.my_each do |el|
      return true if yield(el)
    end
    false
  end

  def my_flatten(arr = nil)
    blank = arr.nil? ? [] : arr
    self.my_each do |el|
      if el.is_a?(Integer)
        blank << el
      else
        el.my_flatten(blank)
      end
    end
    blank
  end

  def my_rotate(shift = 1)
    dupli = self.dup
    (shift.abs).times do
      if shift > 0
        temp = dupli.shift
        dupli << temp
      else
        temp = dupli.pop
        dupli.unshift(temp)
      end
    end
    dupli
  end

  def my_join(str = "")
    result = self[0]
    self[1..-1].my_each do |el|
      result << str + el
    end
    result
  end

  def my_reverse
    blank = []
    self.my_each do |el|
      blank.unshift(el)
    end
    blank
  end

  def my_zip(*args)
    blank = []
    idx = 0
    until blank.length == self.length
      temp = []
      temp << self[idx]
      args.my_each do |arr|
        temp << arr[idx]
      end
      blank << temp
      idx += 1
    end
    blank
  end

end
