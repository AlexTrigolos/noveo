module Tryable
  def try(&block)
    begin
      block.call(self)
    rescue NoMethodError => err
      return nil
    end
  end
end
