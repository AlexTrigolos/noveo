class Circle
  attr_reader :square

  def initialize(radius)
    @radius = radius
    @square = radius * radius * Math::PI
  end

  def <=>(other)
    @square <=> other.square
  end
end
