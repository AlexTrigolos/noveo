def sum_arr(arr)
  if arr.size == 1
    return arr[0]
  end
  arr[0] + sum_arr(arr - arr[0])
end

print sum_arr([1, 2, 3, 4, 5, -12, 143, 3.43 -2.54, 000_000])