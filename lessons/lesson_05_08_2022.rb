# Необходимо реализовать три лямбды, которые меняют строку в зависимости от реализации.
# Затем, надо сделать четвертую лямбду, которая будет принимать два параметра: другую из добавленных лямбд и строку.
# В результате должна быть возвращена измененная строка. Объект исходной строки менять при этом не нужно.

# Тестовые варианты

# spoken = ->(msg) { ... } #=> "Hello."
# shouted = ->(msg) { ... } #=> "HELLO!"
# whispered = ->(msg) { ... } #=> "hello."

# greet = ->(style, msg) { ... }

spoken = ->(msg) { "#{msg.capitalize}." }
shouted = ->(msg) { "#{msg.upcase}!" }
whispered = ->(msg) { "#{msg.downcase}."}
puts spoken.call('hello')
puts shouted.call('hello')
puts whispered.call('hello')
greet = ->(style, msg) { style.call(msg) }
puts greet.call(spoken, 'hello')
puts greet.call(shouted, 'hello')
puts greet.call(whispered, 'hello')


# Есть два класса Duck и Goose. И есть метод, в который передается объект, а у него вызывается метод quack.
# У класса Goose данного метода нет, но, тем не менее, нужно сделать так, чтобы данный класс можно было передать в метод.
# Метод и исходные классы менять запрещено.

# Тестовые варианты

class Duck
  def quack
    'quack'
  end
end

class Goose
  def honk
    'honk'
  end
end

duck = Duck.new
goose = Goose.new

def print_quack(quackable_object)
  puts quackable_object.quack
end

class GooseToDuckAdapter
  def initialize(bird)
    @bird = bird
  end

  def quack
    @bird.honk
  end
end

bird2 = GooseToDuckAdapter.new(goose)

print_quack(duck) # works
print_quack(bird2) # also should works

# Есть класс Ship, у которого есть несколько атрибутов.
# Атрибуты можно установить только при создании нового объекта.
# При этом нужна возможность выполнять DamageUpgrade и ArmorUpgrade действия так,
# чтобы не менять сам объект, но при этом получать улучшенные свойства объекта.
require 'forwardable'

class Ship
  attr_reader :damage, :armor

  def initialize(damage:, armor:)
    @damage = damage
    @armor = armor
  end
end

def ship_specs(ship)
  puts "Ship damage: #{ship.damage}, armor: #{ship.armor}"
end

ship = Ship.new(damage: 1, armor: 1)
ship_specs(ship) #=> damage: 1, armor: 1

class DamageUpgrade
  def initialize(ship, up_damage)
    @ship = ship
    @up_damage = up_damage
  end
  def damage
    @up_damage + @ship.damage
  end
  def armor
    @ship.armor
  end
end

class ArmorUpgrade
  extend Forwardable
  def_delegators :@ship, :damage # для не дублирования def damage

  def initialize(ship, up_armor)
    @ship = ship
    @up_armor = up_armor
  end
  def armor
    @up_armor + @ship.armor
  end
end

ship = DamageUpgrade.new(ship, 9)
ship_specs(ship) #=> damage: 10, armor: 1

ship = ArmorUpgrade.new(ship, 4)

ship_specs(ship) #=> damage: 10, armor: 5
