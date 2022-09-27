class CustomShape
  attr_reader :square

  def initialize(square)
    @square = square
  end

  def <=>(other)
    @square <=> other.square
  end
end
