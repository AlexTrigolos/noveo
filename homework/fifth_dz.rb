class PaginationHelper

  def initialize(array, page_size)
    @array = array
    @page_size = page_size
  end

  def page_count
    array.size / page_size + (array.size % page_size != 0 ? 1 : 0)
  end

  def item_count
    array.size
  end

  def page_item_count(page)
    if page < 0
      -1
    elsif array.size / page_size > page
      page_size
    elsif  array.size / page_size == page && array.size % page_size != 0
      array.size % page_size
    else
      -1
    end
  end

  def page_index(index)
    if index < 0 || index > array.size
      -1
    else
      index / page_size
    end
  end

  private
  attr_reader :page_size, :array
end

helper = PaginationHelper.new(%w[a b c d e f], 4)

puts "helper.page_count = #{helper.page_count}" # 2
puts "helper.page_count = #{helper.item_count}" # 6
puts "helper.page_item_count(0) = #{helper.page_item_count(0)}"  # 4, т.к нумерация страниц с 0
puts "helper.page_item_count(1) = #{helper.page_item_count(1)}" # 2, последняя страница содержит 2 элемента
puts "helper.page_item_count(1) = #{helper.page_item_count(2)}" # -1

# page_index принимает индекс элемента и возвращает страницу, на которой этот элемент находится

puts "helper.page_index(5) = #{helper.page_index(5)}" # 1
puts "helper.page_index(2) = #{helper.page_index(2)}" # 0
puts "helper.page_index(20) = #{helper.page_index(20)}" # -1
puts "helper.page_index(-10) = #{helper.page_index(-10)}" # -1

class Node
  attr_accessor :value
  attr_accessor :nxt
  def initialize(value)
    @value = value
    @nxt = nil
  end

  def to_s
    value.to_s
  end
end

class LinkedList
  attr_accessor :node
  def initialize
    @node = nil
  end

  def append(number)
    nd = Node.new(number)
    last = nil
    save = @node
    until save.nil?
      last = save
      save = save.nxt
    end
    save = nd
    last.nxt = save unless last.nil?
    @node = save if @node.nil?
  end

  def append_after(first, second)
    item = @node
    while item.value != first
      item = item.nxt
      break if item.nil?
    end
    if item.value == first
      nd = Node.new(second)
      nd.nxt = item.nxt
      item.nxt = nd
    end
  end

  def delete(num)
    item = @node
    last = nil
    while item.value != num
      last = item
      item = item.nxt
      break if item.nxt.nil?
    end
    if item.value == num
      if last.nil?
        @node = item.nxt
      else
        last.nxt = item.nxt
      end
    end
  end

  def exists?(num)
    item = @node
    until item.nil?
      if item.value == num
        return true
      end
      item = item.nxt
    end
    false
  end

  def reverse!
    if !@node.nil? and !@node.nxt.nil?
      pred = nil
      now = @node
      post = @node.nxt
      until now.nil?
        now.nxt = pred
        pred = now
        now = post
        post = post.nxt unless post.nil?
      end
      @node = pred
    end
    self
  end

  def reverse
    new_linked_list = LinkedList.new
    now = @node
    until now.nil?
      new_linked_list.append(now)
      now = now.nxt
    end
    new_linked_list.reverse!
  end

  def to_s
    str = '('
    item = @node
    until item.nil?
      str += (item.value.nil? ? '' : item.value.to_s) + (item.nxt.nil? ? '' : ', ')
      item = item.nxt
    end
    str + ')'
  end
end

list = LinkedList.new
puts "#{list} => ()"
list.append(3)
list.append(5)
list.append(10)
puts "#{list} => (3, 5, 10)"

list.append_after(3, 15)
puts "#{list} => (3, 15, 5, 10)"
list.append_after(10, 25)
puts "#{list} => (3, 15, 5, 10, 25)"

list.delete(10)
puts "#{list} => (3, 15, 5, 25)"
puts "#{list.exists?(25)} => true"
puts "#{list.exists?(24)} => false"
puts "#{list.reverse} => (25, 5, 15, 3)"
puts "#{list.reverse!} => (25, 5, 15, 3)"
puts "#{list} => (25, 5, 15, 3)"