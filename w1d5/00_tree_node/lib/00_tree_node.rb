require 'byebug'

class PolyTreeNode
  attr_reader :parent, :children, :value

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(node)
    # debugger
    unless @parent == node
      old_parent = @parent
      @parent = node
      old_parent.remove_child(self) unless old_parent.nil?
      @parent = node
      @parent.add_child(self) unless @parent.nil?
    end
  end

  def add_child(child_node)
    @children << child_node unless @children.include?(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    # raise "Not a child node!" if child_node.parent.nil?

    child_node.parent = nil
    @children.delete(child_node)
  end

  def dfs(target_value)
    return self if self.value == target_value
    self.children.each do |child|
      result = child.dfs(target_value)
      return result unless result.nil?
    end
    nil
  end

  def bfs(target_value)
    bfs_queue = [self]
    until bfs_queue.empty?
      node = bfs_queue.shift
      return node if node.value == target_value
      node.children.each do |child|
        bfs_queue << child
      end
    end
    nil
  end

  def inspect
    "#{self.value}, parent: #{self.parent.value}"
  end
end
