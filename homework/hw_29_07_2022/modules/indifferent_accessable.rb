module IndifferentAccessable
  def [](key)
    begin
      if self.include? key.to_s
        super(key.to_s)
      elsif self.include? key.to_sym
        super(key.to_sym)
      else
        super(key)
      end
    rescue StandardError
      super(key)
    end
  end
end
