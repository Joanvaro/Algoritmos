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

      @adjacent_nodes_friends.each do |friend|
        unless friend.adjacent_nodes_friends.include?(adjacent_node) then
          friend.adjacent_nodes_friends << adjacent_node 
        end

        friend.adjacent_nodes_enemies.each do |newFriend|
          @adjacent_nodes_friends << newFriend unless @adjacent_nodes_friends.include?(newFriend)
        end
      end

    else
      @adjacent_nodes_enemies << adjacent_node

      @adjacent_nodes_enemies.each do |enemy|
        unless enemy.adjacent_nodes_enemies.include?(adjacent_node) then
          enemy.adjacent_nodes_enemies << adjacent_node
        end

        enemy.adjacent_nodes_friends.each do |newEnemy|
          @adjacent_nodes_enemies << newEnemy unless @adjacent_nodes_enemies.include?(newEnemy)
        end
        
      end

    end
  end

end
