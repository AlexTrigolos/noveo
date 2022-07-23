# Нужно реализовать класс BinaryTree, в котором можно будет хранить элементы Node.
# У класса должны быть методы для добавления элемента в дерево, удаления и поиска элемента.
# За тип данных можно принять Integer

# Тестовые варианты

# tree = BinaryTree.new

# tree.add(10) #=> 10
# tree.add(20) #=> 20
# tree.add(30) #=> 30

# tree.delete(10) #=> 10
# tree.delete(25) #=> nil

# tree.find(20) #=> 20
# tree.find(26) #=> nil

class Node
  attr_reader :value
  attr_accessor :left, :right
  def initialize(value, left = nil, right = nil)
    @value = value
    @left = left
    @right = right
  end

  def to_s
    str = value.to_s
    str += " <left> " + left.to_s + " </left>" unless left.nil?
    str += " <right> " + right.to_s + " </right>" unless right.nil?
    str
  end
end

class BinaryTree
  attr_accessor :node
  def initialize
    @node = nil
  end

  def add(value)
    iter = node
    if iter == nil
      @node = Node.new(value)
    else
      prev = node
      while iter != nil
        prev = iter
        iter = iter.value < value ? iter.right : iter.left
      end
      prev.value > value ? prev.left = Node.new(value) : prev.right = Node.new(value)
    end
  end

  def delete(value)
    iter = node
    prev = nil
    while !iter.nil? && iter.value != value
      prev = iter
      iter = iter.value < value ? iter.right : iter.left
    end
  end

  def to_s
    @node.to_s
  end

end

tree = BinaryTree.new

tree.add(10) #=> 10
tree.add(20) #=> 20
tree.add(30) #=> 30
tree.add(15)

print(tree)
