module Capitalize_Each_Word
  def capitalize_each_word
    self.split.map {|elem| elem.capitalize}.join(' ')
  end
end
