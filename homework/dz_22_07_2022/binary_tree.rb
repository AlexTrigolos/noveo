require_relative 'node'
require_relative 'custom_exception'

class BinaryTree
  attr_reader :root
  def initialize
    @root = nil
  end

  def add(value)
    @root.nil? ? @root = Node.new(value, 1) : @root.add(value)
  end

  def delete(value)
    unless @root.nil?
      link = @root.find(value)
      flag = nil
      if link === @root
        flag = true
      end
      return nil if link.nil?
      deleted = link.delete
      @root = deleted if flag
    end
  end

  def find(value)
    unless @root.nil?
      @root.find(value)
    end
  end

  def to_s
    raise CustomException.new("Can't show tree, use DrawTree and give your tree")
  end

end
