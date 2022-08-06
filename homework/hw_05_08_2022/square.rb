class Square
  attr_reader :square

  def initialize(side_len)
    @side_len = side_len
    @square = side_len * side_len
  end
end
