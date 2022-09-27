class Products
  attr_accessor :products

  def initialize
    super
    @products = []
  end

  def push(param)
    @products.push(param)
  end

  def to_s
    result = ''
    string = 0
    @products.each do |elem|
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
