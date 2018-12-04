#! /usr/bin/ruby

require './Graph.rb'

$Operations = Array.new
$WarGraph = Graph.new()

def readFile(filename)
  data = File.readlines(filename)
  data.collect! { |x| x.delete("\n") }

  $NumberOfPeople = data.delete_at(0)

  data.each do |line|
    $Operations << line.split(" ")
  end

end

def BFS(root_node, search_value, relationship)
  visited = []
  to_visit = []

  visited << root_node
  to_visit << root_node

  while !to_visit.empty? do
    current_node = to_visit.shift
    return true if current_node.value == search_value
  
    if relationship.eql?("friend") then
      arry = current_node.adjacent_nodes_friends
    else
      arry = current_node.adjacent_nodes_enemies
    end

    arry.each do |node|
      if !visited.include?(node) then
        visited << node
        to_visit << node
      end # if
    end # each
  end # while

  return false

end

def setFriends(x,y)
  if x.adjacent_nodes_enemies.include?(y) then
    return -1
  else
    x.adjacent_nodes_friends.each do |friend|
      return -1 if friend.adjacent_nodes_enemies.include?(y)
    end

    x.adjacent_nodes_enemies.each do |enemy|
      return -1 if enemy.adjacent_nodes_friends.include?(y)
    end
    # Adding nodes to the graph if exist do not raise an error
    $WarGraph.add_node(x)
    $WarGraph.add_node(y)

    $WarGraph.add_edge(x,y, "friend")
  end

  return nil
end

def setEnemies(x,y)
  if x.adjacent_nodes_enemies.include?(y) then
    return -1
  else
    x.adjacent_nodes_friends.each do |friend|
      return -1 if friend.adjacent_nodes_enemies.include?(y)
    end

    x.adjacent_nodes_enemies.each do |enemy|
      return -1 if enemy.adjacent_nodes_friends.include?(y)
    end
    # Adding nodes to the graph if exist do not raise an error
    $WarGraph.add_node(x)
    $WarGraph.add_node(y)

    $WarGraph.add_edge(x,y, "enemy")
  end

  return nil
end

def areFriends(x,y)
  return (x.adjacent_nodes_friends.include?(y) or y.adjacent_nodes_friends.include?(x)) ? 1 : 0
end

def areEnemies(x,y)
  return (x.adjacent_nodes_enemies.include?(y) or y.adjacent_nodes_enemies.include?(x)) ? 1 : 0
end

readFile(ARGV[0])
$Nodes = Array.new($NumberOfPeople.to_i)

$Operations.each do |set|
  operation = set[0].to_i
  nodeA = set[1].to_i
  nodeB = set[2].to_i

  break if operation.eql?(0) and nodeA.eql?(0) and nodeB.eql?(0)

  $Nodes[nodeA] = Node.new(nodeA) if $Nodes[nodeA].eql?(nil)
  $Nodes[nodeB] = Node.new(nodeB) if $Nodes[nodeB].eql?(nil)

  case operation
  when 1
    ret = setFriends($Nodes[nodeA], $Nodes[nodeB])
  when 2
    ret = setEnemies($Nodes[nodeA], $Nodes[nodeB])
  when 3
    ret = areFriends($Nodes[nodeA], $Nodes[nodeB])
  when 4
    ret = areEnemies($Nodes[nodeA], $Nodes[nodeB])
  end

  puts ret unless ret.eql?(nil)

end
