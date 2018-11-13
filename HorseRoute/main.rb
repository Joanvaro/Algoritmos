#!/usr/bin/ruby

$HorsePosition = Array.new
$WhitePositions = Array.new
$BlackPositions = Array.new
$Board = Array.new(4) { Array.new(4) }
$Tree = Array.new

def readFile(filename)
  data = File.readlines(filename)
  data.collect! { |x| x.delete("\n") }
	
  $HorsePosition = data.delete_at(0).split(',')
  $WhitePositions = data.delete_at(0).split(',')
  $BlackPositions =  data.delete_at(0).split(',')
	
end

def isInsideBoard(x,y,n)
  return (x >= 0 and x < n and y >= 0 and y < n) ? true : false
end

def fillBoard()
  # Fill white pieces
  count = $WhitePositions.size() / 2
  count.times do |val|
    $Board[$WhitePositions[2*val+1].to_i - 1][$WhitePositions[2*val].to_i - 1] = "W"

    $WhitePositions[2*val] = "#{$WhitePositions[2*val]}#{$WhitePositions[2*val+1]}"
    $WhitePositions[2*val+1] = nil

  end

  $WhitePositions.compact!

  # Fill black pieces
  count = $BlackPositions.size() / 2
  count.times do |val|
    $Board[$BlackPositions[2*val+1].to_i - 1][$BlackPositions[2*val].to_i - 1] = "B"
  end

  $Tree.push(["#{$HorsePosition[0].to_i  - 1}#{$HorsePosition[1].to_i - 1}"])
  
end

def findPositions(node = nil)
  dx = [-2,-1,1,2,-2,-1,1,2]
  dy = [-1,-2,-2,-1,1,2,2,1]

  movements = Array.new
  movements.push($HorsePosition[0].to_i)
  movements.push($HorsePosition[1].to_i)

  $Board[movements[1].to_i - 1][movements[0].to_i - 1] = "X"

  dx.size().times do |mov|
    tmpX = movements[0] + dx[mov] - 1
    tmpY = movements[1] + dy[mov] - 1

    if ( isInsideBoard(tmpX,tmpY,4) and ($Board[tmpY][tmpX] != "B") ) then
      if node then
        if !node.include?("#{tmpX}#{tmpY}") then
          #puts "node = #{node}"
          tmpArray = []
          tmpArray.replace(node)
          tmpArray.push("#{tmpX}#{tmpY}")
          #puts "tmpArray = #{tmpArray}"
          #puts "x = #{tmpX}, y = #{tmpY}"
          $Tree.push(tmpArray)
        end
      else
        tmpArray = ["#{tmpX}#{tmpY}"]
        $Tree.push(tmpArray)
      end

      #$Tree.push(tmpArray)
      $Board[tmpY][tmpX] = "S"
    end
  end
end

def moveHorse()
  node = []

  #puts "tmpArray[moveHorse] = #{$Tree}"
  tmpArray = $Tree.pop
  node.replace(tmpArray)
  #puts "node = #{node}"

  tmpPosition = tmpArray.pop.chars
  #puts "Positions = #{tmpPosition}"

  $HorsePosition[0] = tmpPosition[0].to_i + 1
  $HorsePosition[1] = tmpPosition[1].to_i + 1

  findPositions(node)
end

readFile(ARGV[0])
fillBoard()
puts "Horse = #{$HorsePosition}"
puts "White = #{$WhitePositions}"
puts "Black = #{$BlackPositions}"

until $WhitePositions.empty? do
  until $Tree.empty? do
    moveHorse()
    if $WhitePositions.include?($Tree[-1][-1]) then
      puts "Tree = #{$Tree[-1]}"

      piecePosition = ["#{$Tree[-1][-1]}"]

      $HorsePosition[0] = piecePosition[0]
      $HorsePosition[1] = piecePosition[1]

      $WhitePositions.delete($Tree[-1][-1])
      $Tree.clear
      $Tree.push(piecePosition)
      break
    end
  end
end

$Board.each { |x| puts "#{x}" }
