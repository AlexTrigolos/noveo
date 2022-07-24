require_relative 'node'
class BinaryTree
  def initialize
    @root = nil
  end

  def add(value)
    @root.nil? ? @root = Node.new(value, 1) : add_value(value, @root)
  end

  def add_value(value, tree_branch)
    if value > tree_branch.value
      if !tree_branch.right.nil?
        add_value(value, tree_branch.right)
      else
        tree_branch.right = Node.new(value, tree_branch.index * 2 + 1)
        tree_branch.right.parent = tree_branch
      end
    else
      if !tree_branch.left.nil?
        add_value(value, tree_branch.left)
      else
        tree_branch.left = Node.new(value, tree_branch.index * 2)
        tree_branch.left.parent = tree_branch
      end
    end
  end

  def delete(value)
    link = find_value(value, @root)
    return nil if link.nil?
    if link.left.nil? && link.right.nil?
      link.value < link.parent.value ? link.parent.left = nil : link.parent.right = nil
    elsif link.left.nil? && !link.right.nil?
      if link.value < link.parent.value
        link.parent.left = link.right
      else
        link.parent.right = link.right
      end
      link.right.parent = link.parent
      link.right.update_index
      link.right = nil
      link.parent = nil
    elsif !link.left.nil? && link.right.nil?
      if link.value < link.parent.value
        link.parent.left = link.left
      else
        link.parent.right = link.left
      end
      link.left.parent = link.parent
      link.left.update_index
      link.left = nil
      link.parent = nil
    else
      new_el = find_min(link.right)
      new_el.right.parent = new_el.parent if !new_el.right.nil? && new_el.parent != link
      new_el.parent.left = new_el.right if new_el != link.right
      new_el.parent = link.parent
      new_el.right = link.right if link.right != new_el
      link.right.parent = new_el if link.right != new_el
      link.left.parent = new_el
      new_el.left = link.left
      if new_el.parent.nil?
        @root = new_el
      else
        new_el.value < new_el.parent.value ? new_el.parent.left = new_el : new_el.parent.right = new_el
      end
      link.left = nil
      link.right = nil
      link.parent = nil
      new_el.update_index
    end
  end

  def find(value)
    find_value(value, @root)
  end

  def to_s
    tree = @root
    arr = []
    degree = nil
    @root.nil? ? degree = -1 :degree = find_by_index(update_max_index(@root, 1))
    if degree == -1
      return "Empty tree"
    end
    string(tree, arr, 0)
    index = 0
    str = ""
    last = nil
    arr.each do |elem|
      str += " " * (2 ** degree - 2) if degree > 0
      elem.each do |item|
        unless last.nil?
          if last[1] >= 2 ** find_by_index(item[1])
            str += " " * ((item[1] - last[1] - 1) * 2 ** (degree + 2))
          else
            str += " " * ((item[1] - 2 ** find_by_index(item[1])) * 2 ** (degree + 2))
          end
        end
        last = item
        if arr.size > index + 1
          flag = true
          arr[index + 1].each do |el|
            if item[1] * 2 == el[1]
              str += "╔"
              vl = count_sym(degree, item[0], 0.4)
              str += "═" * (vl - 1) if vl > 0
              flag = false
              break
            end
          end
          str += " " * count_sym(degree, item[0], 0.4) if flag
        end
        str += item[0].to_s
        if arr.size > index + 1
          flag = true
          arr[index + 1].each do |el|
            if item[1] * 2 + 1 == el[1]
              flag = false
              vl = count_sym(degree, item[0], 0.6)
              str += "═" * (vl - 1) if vl > 0
              str += "╗"
              break
            end
          end
          str += " " * count_sym(degree, item[0], 0.6) if flag
        end
        str += " " * (2 ** (degree + 1) - 1)
      end
      str += "\n"
      degree -= 1
      index += 1
    end
    str
  end

  private


  def find_by_index(index)
    num = 0
    while 2 ** num < index
      num += 1
    end
    num - 1
  end

  def rank_num(number)
    ranks = 0
    while number > 0
      number /= 10
      ranks += 1
    end
    ranks
  end

  def count_sym(degree, number, rate_side)
    ranks_minus_1 = rank_num(number) - 1
    2 ** degree - (ranks_minus_1.to_f / 2 + rate_side).to_i
  end

  def string(tree, arr, index)
    unless tree.nil?
      if arr[index].nil?
        arr[index] = []
      end
      arr[index].push([tree.value, tree.index])
      if !tree.left.nil? || !tree.right.nil?
        string(tree.left, arr, index + 1)
        string(tree.right, arr, index + 1)
      end
    end
  end

  def find_value(value, link)
    if link.value == value
      link
    else
      if value < link.value && !link.left.nil?
        find_value(value, link.left)
      elsif value > link.value && !link.right.nil?
        find_value(value, link.right)
      else
        nil
      end
    end
  end

  def find_min(link)
    if link.left.nil?
      link
    else
      find_min(link.left)
    end
  end

  def update_max_index(link, index)
    if !link.right.nil?
      update_max_index(link.right, index * 2 + 1)
    elsif !link.left.nil?
      update_max_index(link.left, index * 2)
    else
      index
    end
  end

end
