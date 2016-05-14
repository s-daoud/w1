def sum_to(n)
  return nil if n < 0
  return 1 if n <= 1
  n + sum_to(n - 1)
end

p sum_to(5)
p sum_to(1)
p sum_to(9)
p sum_to(-8)

def add_numbers(nums_array = [])
  return nums_array[0] if nums_array.length <= 1
  nums_array[0] + add_numbers(nums_array[1..-1])
end

p add_numbers([1, 2, 3, 4])
p add_numbers([3])
p add_numbers([-80, 34, 7])
p add_numbers()

def gamma_fnc(n)
  return nil if n < 1
  return 1 if n == 1
  (n - 1) * gamma_fnc(n - 1)
end

p gamma_fnc(0)
p gamma_fnc(1)
p gamma_fnc(4)
p gamma_fnc(8)
