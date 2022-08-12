# TASK 1
# match_last_item(["rsq", "6hi", "g", "rsq6hig"]) #=> true
# match_last_item([1, 2, 3, "12"]) #=> false
# match_last_item(["rsq", true, 3, "rsqtrue3"]) #=> true

def match_last_item(arr)
  sum = ""
  last = arr.last
  arr.each {|elem| sum << elem.to_s if elem != arr.last}
  last == sum
end

puts match_last_item(%w[rsq 6hi g rsq6hig]) #=> true
puts match_last_item([1, 2, 3, "12"]) #=> false
puts match_last_item(["rsq", true, 3, "rsqtrue3"]) #=> true

# TASK 2

f1 = -> { 'hello' }
f2 = -> { -> { 'hello from lambda 2' } }
f3 = -> { -> { -> { 'hello from lambda 3' } } }

# func_sort([f2, f3, f1]) #=> [f1, f2, f3]
# func_sort([f2, 'str']) #=> ['str', f2]

def func_sort(arr)
  arr.sort_by { |elem| nestedness(elem) }
end

def nestedness(elem)
  res = 1
  res += nestedness(elem.call)
  rescue NoMethodError
    0
end

puts func_sort([f2, f3, f1]) #=> [f1, f2, f3]
puts func_sort([f2, 'str']) #=> ['str', f2]

# TASK 3
class PseudoBool
  def ==(other)
    other == true || other == false
  end
end
pseudo_bool = PseudoBool.new
puts pseudo_bool == true
puts pseudo_bool == false
puts pseudo_bool == 1
puts pseudo_bool == pseudo_bool

# TASK 4

class HtmlBuilder
  attr_reader :result
  def initialize(&block)
    @result = "<html>\n"
    # position = 0
    block.call(self)
  end

  def html_doc!
    @result += "</html>"
  end

  private

  def method_missing(method_name, *args)
    if block_given?
      #method_name
      # puts args
      # args.first.call(args.first) #/method_name
    else
      @result += args.empty? ? "\t<#{method_name}></#{method_name}>\n" : "\t<#{method_name}>#{args.first}</#{method_name}>\n"
    end
  end

end

# html_builder = HtmlBuilder.new do |html|
#   html.h1('Hello!')
#   html.p('This is paragraph')
#   html.div('New div element')
# end

# puts html_builder.html_doc!
#=> "<html><body><h1>Hello!</body></html>"

# HW
#
html_builder = HtmlBuilder.new do |html|
  html.body do |body|
    body.h1('Hello!', class_name: 'h1-formatted margin-10')

    body.p('This is paragraph') do |p|
      p.p('Paragraph inside paragraph')
    end

    body.div('New div element') do |div|
      div.p('Paragraph in div')
    end

    body.div(class_name: 'empty-div')
  end
end

HtmlBuilder.new.html_doc! #=> ''

html_builder.html_doc!
# <html>
# 	<body>
#   	<h1 class="h1-formatted margin-10">Hello!</h1>
#     <p>This is paragraph<p>Paragraph inside paragraph</p></p>
#     <div>New div element<p>Paragraph in div</p></div>
#     <div class="empty-div"/>
#   </body>
# </html>
#
#
#

############# HW TASK

# class LinkedList
#   # methods
#
#   def reverse #-> returns new list but current without changes
#   end
#
#   def reverse! #-> current list with reversed node
#   end
# end

