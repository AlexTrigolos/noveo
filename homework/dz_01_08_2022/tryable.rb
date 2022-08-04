module Tryable
  def try(&block)
    block.call(self)
    rescue NoMethodError => err
      nil
  end
end
