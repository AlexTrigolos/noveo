require_relative 'binary_tree'
require_relative 'version_manager'

tree = BinaryTree.new
puts tree
tree.add(10) #=> 10
tree.add(20) #=> 20
tree.add(15) #=> 15
tree.add(30) #=> 30
tree.add(5) #=> 5
tree.add(2) #=> 2
tree.add(7) #=> 7
tree.add(25) #=> 25
tree.add(6) #=> 6
tree.add(21) #=> 21
tree.add(17) #=> 17
tree.add(32) #=> 32
tree.add(1) #=> 1
tree.add(8) #=> 8
tree.add(3) #=> 3
tree.add(22) #=> 22
tree.add(100) #=> 100
tree.add(99) #=> 99
tree.add(101) #=> 101
puts tree
tree.delete(10) #=> 10
puts "delete 10", tree
tree.delete(99) #=> 99
puts "delete 99", tree
tree.delete(11111111) #=> nil
puts "delete 11111111", tree
tree.delete(25) #=> 25
puts "delete 25", tree

puts tree.find(20).value #=> 20
puts tree.find(26).class #=> nil

# Нужно реализовать класс VersionManager. Конструктор опционально должен принимать строку - версию.
# Допустимые варианты строки: “{major}” (“1”), “{major}.{minor}” (“1.1”), “{major}.{minor}.{patch}” (“1.1.1”).
# В варианте типа "1.1.1.1.1" оставить только первые три значения версии.
# Если часть версии - не целое число (напр. "а.4.е"), то генерировать ошибку.
# Если версия не указана, то значение по умолчанию - “0.0.1”.

vm = VersionManager.new
puts vm
vm = VersionManager.new("1")
puts vm
vm = VersionManager.new("1.2")
puts vm
vm = VersionManager.new("1.2.3")
puts vm
vm = VersionManager.new("1.2.3.4")
puts vm
vm = VersionManager.new("0.0.0.13.666")
puts vm
# vm = VersionManager.new("1.22.a")
# puts vm
vm = VersionManager.new("1.7.3.kdsfuhfuehfue839823893")
puts vm

vm.major! # увеличивает мажорную версию, устанавливая минорную и патч в 0 (напр. “2.0.0”)
puts vm
vm.minor! # увеличивает минорную версию, устанавливая патч в 0 (напр. “2.1.0”)
puts vm
vm.patch! # увеличивает патч версию (напр. “2.1.1”)
puts vm

vm.rollback! # возвращается к прошлой версии, если это возможно, иначе выдать ошибку
puts vm
vm.rollback! # возвращается к прошлой версии, если это возможно, иначе выдать ошибку
puts vm
vm.rollback! # возвращается к прошлой версии, если это возможно, иначе выдать ошибку
puts vm
begin
  vm.rollback! # возвращается к прошлой версии, если это возможно, иначе выдать ошибку
rescue Exception => e
  puts "Ошибка #{e.class} #{e.message}"
ensure
  puts vm
  puts vm.release # возвращает текущую версию в формате “{major}.{minor}.{patch}”
end