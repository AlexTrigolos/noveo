class Triangle
  attr_reader :square

  def initialize(height, base)
    @height = height
    @base = base
    @square = height * base / 2
  end

  def <=>(other)
    @square <=> other.square
  end
end
