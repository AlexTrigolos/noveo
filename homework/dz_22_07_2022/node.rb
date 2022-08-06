class Node
  attr_reader :value
  attr_accessor :left, :right, :parent, :index
  def initialize(value, index, left = nil, right = nil, parent = nil)
    @value = value
    @left = left
    @right = right
    @parent = parent
    @index = index
  end

  def update_index
    if @parent.nil?
      @index = 1
    else
      @value < @parent.value ? @index = @parent.index * 2 : @index = @parent.index * 2 + 1
    end
    @left.update_index unless @left.nil?
    @right.update_index unless @right.nil?
  end

  def add(value)
    add_value(value, self)
  end

  def update_max_index(value)
    private_update_max_index(self, value)
  end

  def find(value)
    find_value(value, self)
  end

  def delete
    if self.left.nil? && self.right.nil?
      self.value < self.parent.value ? self.parent.left = nil : self.parent.right = nil
    elsif self.left.nil? && !self.right.nil?
      self.del_have_right
    elsif !self.left.nil? && self.right.nil?
      self.del_have_left
    else
      self.del_have_both
    end
  end

  private

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

  def del_have_right
    if self.value < self.parent.value
      self.parent.left = self.right
    else
      self.parent.right = self.right
    end
    self.right.parent = self.parent
    self.right.update_index
    self.right = nil
    self.parent = nil
  end

  def del_have_left
    if self.value < self.parent.value
      self.parent.left = self.left
    else
      self.parent.right = self.left
    end
    self.left.parent = self.parent
    self.left.update_index
    self.left = nil
    self.parent = nil
  end

  def del_have_both
    new_el = find_min(self.right)
    new_el.right.parent = new_el.parent if !new_el.right.nil? && new_el.parent != self
    new_el.parent.left = new_el.right if new_el != self.right
    new_el.parent = self.parent
    new_el.right = self.right if self.right != new_el
    self.right.parent = new_el if self.right != new_el
    self.left.parent = new_el
    new_el.left = self.left
    self.left = nil
    self.right = nil
    self.parent = nil
    new_el.update_index
    if new_el.parent.nil?
      return new_el
    end
    new_el.value < new_el.parent.value ? new_el.parent.left = new_el : new_el.parent.right = new_el
  end

  def find_value(value, link)
    if link.nil?
      nil
    elsif link.value == value
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

  def private_update_max_index(link, index)
    if !link.right.nil?
      private_update_max_index(link.right, index * 2 + 1)
    elsif !link.left.nil?
      private_update_max_index(link.left, index * 2)
    else
      index
    end
  end

end