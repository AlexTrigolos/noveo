require_relative 'tryable'

FalseClass.include Tryable
Integer.include Tryable
TrueClass.include Tryable

puts false.try { even? }.class # nil
puts false.try(&:even?).class # nil
puts 2.try(&:even?) # true
puts 1.try { |obj| obj + 1 } # 2
puts true.try { |obj| obj + 1 }.class # nil
begin
puts 1.try { |obj| obj + '' } # it still should raise error “String can't be coerced into Integer”
rescue TypeError => err
  puts "Error - #{err.class}, message - #{err}"
end

#############################################Task 2#############################################
require_relative 'add_num_to_proc'

add_num_1 = add_num(1) # proc

puts add_num_1.call(3) # 4
puts add_num_1.call(5.7) # 6.7

add_num_m10 = add_num(-10)

puts add_num_m10.call(44) # 34
puts add_num_m10.call(-20) # -30
