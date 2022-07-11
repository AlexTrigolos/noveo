puts "------------------МАССИВЫ----------------"
mas = [0, 'a']
mas2 = [-1, 'q']
array = [1, 2, mas2, 'c', mas]
array.cycle(3) { |elem| p elem} # делает 3 повтора, без параметра бесконечно раз
print "\n"
p array.dig(4, 1) # извлекает элемент в вложенном масиве
print "\n"
p array.flatten(1) # вытаскивает вложенные массивы первого уровня, для 2 до второго уровня, без параметра все вложенности
print "\n"
p array.rassoc('a') # находит первый подмасив в котором есть искомый элемент
print "\n"
p [[1, 3, 5], [2, 4, 6]].transpose # транспонирует массив, меняет строки и столбцы
puts "-----------------ХЭШИ----------------"
buf = [:second]
hash = {:first => 1, buf=> "2", 'third': :three, :buff => nil}
p hash
p hash.compact! # удалает ключи с занчение nil
buf[0] = :qwe
p hash.include?(buf)
p hash.rehash # при обновлении названий включающих себя элементов делает заново хэширование для корректного отображения включающих ключей
p hash.include?(buf)
p hash.fetch_values(:third, buf, "havn't") {|key| key.to_s} # возвращает массив значений по ключам или шаблон
hash.delete(buf)
p hash.reject {|key, value| key.start_with?('f') } # оставляет только те что не подходят под условию, обратный этому методу keep_if
p hash.invert # меняет ключи и значения местаами
puts "-----------------ДИАПОЗОНЫ----------------"
range1 = (1..10)
range2 = ('a'...'z')
p range1.bsearch{|el| el > 5} # возвращает первое подходящее число
p range2.cover?('zq') # ищет вхождение первого символа
p range2.cover?('qz')
p range1.exclude_end? # является ли включающим последний символ/число/что-либо_ещё
p range2.exclude_end?
p range2.include?(10) # входил ли в диапозон
p range1.include?('z')
range1.step(2) {|el| print (el**2).to_s + " "} # делает шаги и действия с ними
range2.step(4) {|el| print el}
puts ''
puts "-----------------МНОЖЕСТВА----------------"
require 'set'
set = Set[1, 2, 4, 4]
p set
p set.add?(2) # с знаком ? возвращает nil если такой элемент уже присутствует
p set.delete?(3) # с знаком ? возвращает nil если такой элемент отсутствует
p set.disjoint? Set[3, 6] # true если нет ни одного совпадений, intersect? возвращает true если есть хоть одно совпадение
p set.proper_subset? Set[1, 2, 4, 3] # true если первое подмножество второго, для proper_superset наоборот (subset?, superset?)
p set.divide {|i, j| (i - j).abs == 1} # создает подмножества по условию
