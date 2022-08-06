class Rectangle
  attr_reader :square

  def initialize(length, width)
    @length = length
    @width = width
    @square = length * width
  end
end

