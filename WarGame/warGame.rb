#! /usr/bin/ruby

require './Graph.rb'

$Operations = Array.new

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
  #TODO Checar el error de checkeo
  puts "x = #{x.value} y = #{y.value}"
  puts  BFS(x, y.value, "enemy")
  if BFS(x, y.value, "enemy") then
    puts "-1"
  else
    x.adjacent_nodes_friends.each do |friend|
      #puts "friend = #{friend.value} x = #{x.value}"
      #puts "-1" if BFS(friend, y.value, "enemy")
      puts
      puts BFS(friend, y.value, "enemy")
      puts
    end

    # Adding nodes to the graph if exist do not raise an error
    $FriendGraph.add_node(x)
    $FriendGraph.add_node(y)

    $FriendGraph.add_edge(x,y, "friend")
  end
end

def setEnemies(x,y)
  ret = BFS(x, y.value, "friend")

  x.adjacent_nodes_enemies.each do |enemy|
    puts "-1" if BFS(enemy, y.value, "friend")
  end

  if ret then
    puts "-1"
  else
    # Adding nodes to the graph if exist do not raise an error
    $FriendGraph.add_node(x)
    $FriendGraph.add_node(y)

    $FriendGraph.add_edge(x,y, "enemy")
  end
end

def areFriends(x,y)
  return BFS(x,y.value, "friend") ? 1 : 0
end

def areEnemies(x,y)
  return BFS(x,y.value, "enemy") ? 1 : 0
end

$FriendGraph = Graph.new()

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
    setFriends($Nodes[nodeA], $Nodes[nodeB])
  when 2
    setEnemies($Nodes[nodeA], $Nodes[nodeB])
  when 3
    puts areFriends($Nodes[nodeA], $Nodes[nodeB])
  when 4
    puts areEnemies($Nodes[nodeA], $Nodes[nodeB])
  end
end

=begin
node0 = Node.new(0)
node1 = Node.new(1)
node2 = Node.new(2)
node3 = Node.new(3)
node4 = Node.new(4)
node5 = Node.new(5)

setFriends(node0, node1)
setFriends(node0, node3)
setFriends(node1, node4)

setEnemies(node2, node5)

puts areFriends(node0, node4)
puts areFriends(node0, node5)

puts areEnemies(node2, node5)

setEnemies(node0, node4)
=end
