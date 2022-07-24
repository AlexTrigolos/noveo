class Node
  attr_reader :value
  attr_accessor :left, :right, :parent, :index
  def initialize(value, index, left = nil, right = nil, parent = nil)
    @value = value
    @left = left
    @right = right
    @parent = parent
    @index = index
  end

  def update_index
    unless @parent.nil?
      @value < @parent.value ? @index = @parent.index * 2 : @index = @parent.index * 2 + 1
    else
      @index = 1
    end
    @left.update_index unless @left.nil?
    @right.update_index unless @right.nil?
  end

end