# Создать модуль с набором полезных методов для строк. Например, чтобы модуль содержал метод capitalize_each_word:
# 'some new string'.capitalize_each_word #=> "Some New String"
#
# 1-ый вариант использования
#
# 'string one'.capitalize_each_word
# 'string two'.capitalize_each_word
#
# 2-ый вариант использования
#
# str1 = 'string one'
# str2 = 'string two'
# ....
# str1.capitalize_each_word #=> "String One"
# str2.capitalize_each_word #=> NoMethodError
require_relative 'modules/capitalize_each_word' # comment this for 2 part

class String # comment this for 2 part
  include Capitalize_Each_Word # comment this for 2 part
end # comment this for 2 part
puts 'string one'.capitalize_each_word # comment this for 2 part
puts 'string two'.capitalize_each_word # comment this for 2 part
# start 2 part
str1 = 'string one'
str2 = 'string two'
str1.singleton_class.include(Capitalize_Each_Word)
puts str1.capitalize_each_word #=> "String One"
sleep(1) # для последовательного отображения
puts str2.capitalize_each_word #=> NoMethodError

# 2 task
# Снова вернемся к задаче с хешом, которую мы делали, когда строковые и символьные ключи доступны
# по одинаковым ключам. Решить только надо теперь с использованием модуля, который будет дополнять
# текущий хеш дополнительным функционалом
require_relative 'modules/indifferent_accessable'
class Hash
  def make_indifferent_accessable!
    self.singleton_class.prepend IndifferentAccessable
    self
  end
end

hash1 = { a: 1, 'b' => 2, 1 => 3 }.make_indifferent_accessable! # можно вызвать метод так

puts hash1['a'] #=> 1
puts hash1[:b] #=> 2
puts hash1[1] #=> 3

hash2 = { d: 3, true => 'True' }
puts hash2.make_indifferent_accessable!['d'] # можно и так, сразу обращаться по ключу
puts hash2[true] #=> True
puts hash2[nil].class #=> nil
