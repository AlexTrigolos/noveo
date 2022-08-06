class DrawTree
  def initialize(tree)
    @root = tree.root
  end

  def to_s
    tree = @root
    arr = []
    degree = nil
    if @root.nil?
      return "Empty tree"
    else
      degree = find_by_index(@root.update_max_index(1))
    end
    string(tree, arr, 0)
    start_draw_lines(arr, degree)
  end

  private

  def start_draw_lines(arr, degree)
    index = 0
    str = ""
    last = nil
    arr.each do |elem|
      str += " " * (2 ** degree - 2) if degree > 0
      result = draw_elems(arr, degree, elem, index, last)
      str += result[0]
      last = result[1]
      str += "\n"
      degree -= 1
      index += 1
    end
    str
  end

  def draw_elems(arr, degree, elem, index, last)
    str = ""
    elem.each do |item|
      unless last.nil?
        if last[1] >= 2 ** find_by_index(item[1])
          str += " " * ((item[1] - last[1] - 1) * 2 ** (degree + 2))
        else
          str += " " * ((item[1] - 2 ** find_by_index(item[1])) * 2 ** (degree + 2))
        end
      end
      last = item
      str += left_brackets(arr, degree, item, index)
      str += item[0].to_s
      str += right_brackets(arr, degree, item, index)
      str += " " * (2 ** (degree + 1) - 1)
    end
    [str, last]
  end

  def left_brackets(arr, degree, item, index)
    str = ""
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
    str
  end

  def right_brackets(arr, degree, item, index)
    str = ""
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
    str
  end

  def find_by_index(index)
    num = 0
    while 2 ** num < index
      num += 1
    end
    num - 1
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

  def count_sym(degree, number, rate_side)
    ranks_minus_1 = rank_num(number) - 1
    2 ** degree - (ranks_minus_1.to_f / 2 + rate_side).to_i
  end

  def rank_num(number)
    ranks = 0
    while number > 0
      number /= 10
      ranks += 1
    end
    ranks
  end

end
