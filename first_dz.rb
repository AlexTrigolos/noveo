def sum_arr(arr)
  if arr.size == 1
    return arr[0]
  end
  arr.shift + sum_arr(arr) # arr.shift можно заменить на arr.pop
  # arr.sum() # всё можно заменить на эту строку
end

puts sum_arr(gets.split().map(&:to_f)) # может быть NoMethodError (Method invocation 'split' may produce 'NoMethodError' )
# на удивление в ruby если не задавать параметры для split, то ему не важно " ", ", ", "; " как минимум)
puts sum_arr([1, 2, 3, 4, 5, -12, 143, 3.43, -2.54, 000_000])