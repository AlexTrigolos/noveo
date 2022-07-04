def sum_arr(arr)
  if arr.size == 1
    return arr[0]
  end
  arr.shift + sum_arr(arr) # arr.shift можно заменить на arr.pop
  # arr.sum() # всё можно заменить на эту строку
end

print sum_arr([1, 2, 3, 4, 5, -12, 143, 3.43, -2.54, 000_000])