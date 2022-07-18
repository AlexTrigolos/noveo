# Нужно реализовать класс HashWithIndifferentAccess, который позволит обращаться к ключу-строке по символу и наоборот.
# Для это следует расширить существующий класс Hash. Также добавить метод для перехода от обычного хеша к модифицированному.

# Тестовые варианты

# h = { a: 'apple' }.with_indifferent_access
# puts h['a'] # => apple
# hash[:foo] = 'bar'
# puts hash['foo']  # => bar

class HashWithIndifferentAccess < Hash
  def [](key) # key == :a => 'a'; key == 'a' => 'a'; real_key = :a
    key = key.is_a?(String) ? key.to_sym : key
    self.each do |skey, svalue|
      return svalue if skey == key
    end
    nil
  end
end


class Hash
  def with_indifferent_access #: return HashWithIndifferentAccess
    # new = HashWithIndifferentAccess.new(0)
    # self.each { |key, value| new[key] = value}
    # new
    HashWithIndifferentAccess[self]
  end
end

# simple_hash = { a: 'apple', 'b': 1 } # simple_hash.class => Hash
# hash_with_indif_acc = { a: 'apple', 'b': 1 }.with_indifferent_access # hash_with_indif_acc.class => HashWithIndifferentAccess

simple_hash = Hash[a: 'apple', 'b': 1, 1 => 6] # simple_hash.class => Hash
p simple_hash
p simple_hash.class
hash_with_indif_acc = simple_hash.with_indifferent_access # hash_with_indif_acc.class => HashWithIndifferentAccess
p hash_with_indif_acc
p hash_with_indif_acc.class
p hash_with_indif_acc['a']
p hash_with_indif_acc[:a]
p hash_with_indif_acc['b']
p hash_with_indif_acc[:b]
p hash_with_indif_acc['c']
p hash_with_indif_acc[:c]
p hash_with_indif_acc[1]

# hash_with_indif_acc.get_key(:a) == hash_with_indif_acc[:a] == hash_with_indif_acc.get_key('a')
# hash_with_indif_acc.get_key('b') == hash_with_indif_acc['b'] == hash_with_indif_acc.get_key(:b)

# //////////////////////////////////////////////////////////////////////////////////////////////

# Нужно реализовать класс Vector с соответствующими методами по сложению,
# вычитанию векторов. Если оперируемые векторы разной длины, то это должна быть ошибка или nil результат.

# Тестовые варианты

# a = Vector.new([1, 2, 3])
# b = Vector.new([3, 4, 5])
# c = Vector.new([5, 6, 7, 8])

# a.add(b)      # should return a new Vector([4, 6, 8])
# a.subtract(b) # should return a new Vector([-2, -2, -2])
# a.dot(b)      # should return 1*3 + 2*4 + 3*5 = 26
# a.norm()      # should return sqrt(1^2 + 2^2 + 3^2) = sqrt(14)
# a.add(c)      # throws an nil
# a.to_s        # (1, 2, 3)

class Vector
  attr_reader :vector

  def initialize(vector)
    @vector = vector
  end

  def same_size?(other_vec)
    vector.size == other_vec.vector.size
  end

  def [](index)
    vector.to_a[index]
  end

  def add(other_vec)
    return nil unless same_size?(other_vec)
    index = 0
    res_vec = Vector.new(vector.dup)
    res_vec.vector.each do |elem|
      res_vec.vector[index] = elem + other_vec[index]
      index += 1
    end
    res_vec
  end

  def subtract(other_vec)
    return nil unless same_size?(other_vec)
    index = 0
    res_vec = Vector.new(vector.dup)
    res_vec.vector.each do |elem|
      res_vec.vector[index] = elem - other_vec[index]
      index += 1
    end
    res_vec
  end

  def dot(other_vec)
    return nil unless same_size?(other_vec)
    index = 0
    res_dot = 0
    vector.each do |elem| # да можно без self, но я так хочу и считаю так нагляднее хотя хз
      res_dot += elem * other_vec[index]
      index += 1
    end
    res_dot
  end

  def norm
    res_norm = 0
    vector.each { |elem| res_norm += elem ** 2 }
    Math.sqrt(res_norm)
  end

  def to_s
    "(" + vector.join(", ") + ")"
  end

end

a = Vector.new([1, 2, 3])
b = Vector.new([3, 4, 5])
c = Vector.new([5, 6, 7, 8])
p a.add(b)
p a.subtract(b)
p a.dot(b)
p a.norm
p a.add(c)
p a.to_s

