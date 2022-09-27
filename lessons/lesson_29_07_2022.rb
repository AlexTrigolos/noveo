module Database
  class ConnectionPool
    private_class_method :new
    def connections_count
      5
    end

    def add
    end

    def execute
    end

    def self.instance
      @instance ||= self.new
    end
  end
end

puts Database::ConnectionPool.instance.object_id #=> object_id = 123

puts Database::ConnectionPool.instance.object_id #=> object_id = 123
# puts Database::ConnectionPool.new.object_id #=> error NoMethodError

#_______________________________________2 TASK______________________________________________

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

module CapitalizeEachWord
  def capitalize_each_word
    self.split.map {|elem| elem.capitalize}.join(' ')
  end
end

# class String
#   include Capitalize_Each_Word
# end
#
# puts 'string one'.capitalize_each_word
# puts 'string two'.capitalize_each_word


str1 = 'string one'
str2 = 'string two'
str1.singleton_class.include(CapitalizeEachWord)
puts str1.capitalize_each_word #=> "String One"
puts str2.capitalize_each_word #=> NoMethodError