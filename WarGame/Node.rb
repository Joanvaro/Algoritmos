#! /usr/bin/ruby

class Node

  attr_reader :value, :adjacent_nodes_friends, :adjacent_nodes_enemies

  def initialize(value)
    @value = value
    @adjacent_nodes_friends = []
    @adjacent_nodes_enemies = []
  end

  def add_edge(adjacent_node, relationship)

    if relationship.eql?("friend") then
      @adjacent_nodes_friends << adjacent_node
    else
      @adjacent_nodes_enemies << adjacent_node
    end

  end

end
