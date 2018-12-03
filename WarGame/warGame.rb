#! /usr/bin/ruby

require './Graph.rb'

def BFS(root_node, search_value)
  visited = []
  to_visit = []

  visited << root_node
  to_visit << root_node

  while !to_visit.empty? do
    current_node = to_visit.shift
    return true if current_node.value == search_value

    current_node.adjacent_nodes.each do |node|
      if !visited.include?(node) then
        visited << node
        to_visit << node
      end # if
    end # each
  end # while

end

def setFriends(x,y)
  # Adding nodes to the graph if exist do not raise an error
  $FriendGraph.add_node(x)
  $FriendGraph.add_node(y)

  $FriendGraph.add_edge(x,y)
end

def setEnemies(x,y)
  # Adding nodes to the graph if exist do not raise an error
  $EnemyGraph.add_node(x)
  $EnemyGraph.add_node(y)

  $FrienGraph.add_edge(x,y)
end

def areFriends(x,y)
  #TODO check relationships
  return BFS(x,y.value) ? 1 : 0
end

def areEnemies(x,y)
  #TODO check relationships
end

$FriendGraph = Graph.new()
$EnemyGraph = Graph.new()

node0 = Node.new(0)
node1 = Node.new(1)
node2 = Node.new(2)
node3 = Node.new(3)
node4 = Node.new(4)
node5 = Node.new(5)

setFriends(node0, node1)
setFriends(node0, node3)
setFriends(node1, node4)

puts areFriends(node0, node4)
puts areFriends(node0, node5)
