def sum_arr(arr)
  if arr.size == 1
    return arr[0]
  end
  arr.shift + sum_arr(arr) # arr.shift можно заменить на arr.pop
  # arr.sum() # всё можно заменить на эту строку
end

our_arr = gets.split(", ") # 1, 2, 3, 4, 5, -12, 143, 3.43, -2.54, 000_000
# our_arr.each { |elem| puts Float(elem).class == Float }
begin
  if our_arr.all?{|elem| Float(elem).class == Float}
    puts sum_arr(our_arr.map(&:to_f)) # может быть NoMethodError (Method invocation 'split' may produce 'NoMethodError' )
  end
rescue
  puts "Your data is a very big шняга, в общем не только числа :D"
end
puts sum_arr([1, 2, 3, 4, 5, -12, 143, 3.43, -2.54, 000_000])