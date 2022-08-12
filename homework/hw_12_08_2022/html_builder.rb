class HtmlBuilder
  attr_reader :result
  def initialize(&block)
    @result = ""
    @tab = 1
    block.call(self) if block_given?
  end

  def html_doc!
    if @result != ""
      @result = "<html>\n#{@result}</html>"
    end
    result
  end

  private
  attr_accessor :tab
  def method_missing(method_name, *args, class_name: nil, &block)
    @result +=  " " * 2 * @tab + "<#{method_name}"
    unless class_name.nil?
      @result += " class=\"#{class_name}\""
    end
    if args.empty? and !block_given?
      @result += "/>"
    else
      @result += ">#{args.first}"
    end
    if block_given?
      @result += "\n"
      @tab += 1
      block.call(self)
      @tab -= 1
    end
    if !args.empty? or block_given?
      if block_given?
        @result += " " * 2 * @tab
      end
      @result += "</#{method_name}>"
    end
    @result += "\n"
  end
end
