def merge_arrays(arr1, arr2)
  res = []
  if arr1[0] > arr1[arr1.size - 1]
    arr1 = arr1.reverse
  end
  if arr2[0] > arr2[arr2.size - 1]
    arr2 = arr2.reverse
  end
  while arr1.size > 0 && arr2.size > 0 do
    if arr1[0] < arr2[0]
      if !res.include? arr1[0]
        res.push(arr1.shift)
      else
        arr1.shift
      end
    else
      if !res.include? arr2[0]
        res.push(arr2.shift)
      else
        arr2.shift
      end
    end
  end
  while arr1.size > 0 do
    if !res.include? arr1[0]
      res.push(arr1.shift)
    else
      arr1.shift
    end
  end
  while arr2.size > 0 do
    if !res.include? arr2[0]
      res.push(arr2.shift)
    else
      arr2.shift
    end
  end
  res
end

def remove_min(arr)
  min = arr[0]
  count = 0
  res = []
  num = nil
  arr.each { |elem|
    if elem < min
      min = elem
      num = count
    end
    res.push(elem)
    count += 1
  }
  unless num.nil?
    res.delete_at(num)
  end
  res
end

p merge_arrays([0, 1, 2, 5, 8, 10], [10, 9, 4, 3])
p remove_min([3, 5, 2, 6, 2])