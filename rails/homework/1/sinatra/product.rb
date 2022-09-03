class Product
  attr_accessor :product

  def initialize
    super
    @product = []
  end

  def push(param)
    @product.push(param)
  end

  def to_s
    result = ''
    string = 0
    @product.each do |elem|
      result += '<br>' unless string.zero?
      index = 0
      elem.each do |el|
        result += ', ' unless index.zero?
        result += el
        index += 1
      end
      string += 1
    end
    result
  end
end
