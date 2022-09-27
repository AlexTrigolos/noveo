module CapitalizeEachWord
  def capitalize_each_word
    self.split.map {|elem| elem.capitalize}.join(' ')
  end
end
