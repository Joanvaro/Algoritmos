#! /usr/bin/ruby

require './Node.rb'

class Graph

  def initialize
    @nodes = {}
  end

  def add_node(node)
    @nodes[node.value] = node
  end

  def add_edge(node1, node2, relationship)
    @nodes[node1.value].add_edge(@nodes[node2.value], relationship)
    @nodes[node2.value].add_edge(@nodes[node1.value], relationship)
  end

end
