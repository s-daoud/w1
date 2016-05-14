require 'byebug'

def range(start, end_point)
  return [] if end_point <= start
  return [] if start + 1 == end_point
  between_nums = [start + 1]
  between_nums + range(start + 1, end_point)
end

# p range(1, 5)
# p range(2, 3)
# p range(2, 4)
# p range(2, 2)
# p range(2, 1)

def add_nums(arr)
  return nil if arr.length == 0
  return arr[0] if arr.length == 1
  arr[0] + add_nums(arr[1..-1])
end

# p add_nums([1,2,3])
# p add_nums([])
# p add_nums([1])

def add_nums_iterative(arr)
  return nil if arr.length == 0
  total = 0
  arr.each do |num|
    total += num
  end
  total
end

# p add_nums_iterative([1,2,3])
# p add_nums_iterative([])
# p add_nums_iterative([1])

def exponentiation_one(base, exp)
  return nil if exp < 0
  return 1 if exp == 0
  return base if exp == 1

  base * exponentiation_one(base, exp - 1)
end

# p exponentiation_one(2, 3)

def exponentiation_two(base, exp)
  return nil if exp < 0
  return 1 if exp == 0
  return base if exp == 1

  even_n = exponentiation_two(base, exp / 2)
  return even_n * even_n if exp.even?

  odd_n = exponentiation_two(base, (exp - 1) / 2)
  odd_n * odd_n * base
end

# p exponentiation_one(2, 5000)
# p exponentiation_two(2, 256)

class Array
  def deep_dup
    copy = []
    self.each do |el|
      copy << (el.is_a?(Array) ? el.deep_dup : el)
    end
    copy
  end
end

def recursive_fib(n)
  return [] if n <= 0
  return [1] if n == 1
  return [1, 1] if n == 2

  prev_fib = recursive_fib(n - 1)
  fib_array = prev_fib << (prev_fib[-1] + prev_fib[-2])
end

def iterative_fib(n)
  copy = []
  if n == 0
    copy
  elsif n == 1
    copy << 1
  elsif n >= 2
    copy = [1, 1]
    until copy.length == n
      copy << copy[-1] + copy[-2]
    end
    copy
  end
end

def binary_search(arr, target)
  copy = arr.sort
  return nil if copy.length == 0
  pivot_idx = copy.length / 2
  pivot = copy[pivot_idx]
  if pivot == target
    return pivot_idx
  elsif target < pivot
    found_idx = binary_search(copy.select { |el| el < pivot }, target)
  else
    found_idx = binary_search(copy.select { |el| el > pivot }, target)
  end
  if found_idx && target > pivot
    found_idx += pivot_idx
    found_idx += 1
  end
  found_idx
end

# p binary_search([1, 2, 3], 1) # => 0
# p binary_search([2, 3, 4, 5], 3) # => 1
# p binary_search([2, 4, 6, 8, 10], 6) # => 2
# p binary_search([1, 3, 4, 5, 9], 5) # => 3
# p binary_search([1, 2, 3, 4, 5, 6], 6) # => 5
# p binary_search([1, 2, 3, 4, 5, 6], 0) # => nil
# p binary_search([1, 2, 3, 4, 5, 7], 6) # => nil

def merge_sort(arr)
  return arr if arr.length <= 1
  first_half = arr[0...(arr.length / 2)]
  second_half = arr[(arr.length / 2)..-1]
  merge(merge_sort(first_half), merge_sort(second_half))
end

def merge(arr1, arr2)
  result = []
  until arr1.empty? && arr2.empty?
    if arr1.empty?
      result << arr2.shift
    elsif arr2.empty?
      result << arr1.shift
    elsif arr1.first < arr2.first
      result << arr1.shift
    else
      result << arr2.shift
    end
  end
  result
end

def subset(arr)
  return [[]] if arr.length == 0
  sub_arr = subset(arr[0...-1])
  sub_arr += sub_arr.deep_dup.each { |el| el << arr.last }
end

def make_change(total, coins)
  coins_copy = coins.dup
  total_copy = total

  result = []
  return result if coins.length == 0
  (total / coins.first).times do
    result << coins.first
    total -= coins.first
  end
  coins.shift
  result += make_change(total, coins)

  other_guess = make_change(total_copy, coins_copy[1..-1])
  return result if other_guess.empty?
  result.length <= other_guess.length ? result : other_guess
end
