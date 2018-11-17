#!/usr/bin/ruby

$BoardSize = 4
$HorsePosition = Array.new
$WhitePositions = Array.new
$BlackPositions = Array.new
$Board = Array.new($BoardSize) { Array.new($BoardSize) }
$Tree = Array.new

def readFile(filename)
  data = File.readlines(filename)
  data.collect! { |x| x.delete("\n") }
	
  $HorsePosition = data.delete_at(0).split(',')
  $WhitePositions = data.delete_at(0).split(',')
  $BlackPositions =  data.delete_at(0).split(',')
	
end

def isInsideBoard(x,y)
  return (x >= 0 and x < $BoardSize and y >= 0 and y < $BoardSize) ? true : false
end

def fillBoard()
  # Fill white pieces
  count = $WhitePositions.size() / 2
  count.times do |val|

    $WhitePositions[2*val] = "#{$WhitePositions[2*val].to_i - 1}#{$WhitePositions[2*val+1].to_i - 1}"
    $WhitePositions[2*val+1] = nil

  end

  $WhitePositions.compact!

  # Fill black pieces
  count = $BlackPositions.size() / 2
  count.times do |val|
    $Board[$BlackPositions[2*val+1].to_i - 1][$BlackPositions[2*val].to_i - 1] = "B"

    $BlackPositions[2*val] = "#{$BlackPositions[2*val].to_i - 1}#{$BlackPositions[2*val+1].to_i - 1}"
    $BlackPositions[2*val+1] = nil

  end

  $BlackPositions.compact!

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

    position = "#{tmpX}#{tmpY}"

    if ( isInsideBoard(tmpX,tmpY) and not ($BlackPositions.include?(position)) ) then
      if node then
        if !node.include?(position) then
          tmpArray = []
          tmpArray.replace(node)
          tmpArray.push(position)
          $Tree.push(tmpArray)
        end
      else
        tmpArray = [position]
        $Tree.push(tmpArray)
      end

      $Board[tmpY][tmpX] = "S"
    end
  end
end

def moveHorse()
  node = []

  tmpArray = $Tree.pop
  node.replace(tmpArray)

  tmpPosition = tmpArray.pop.chars

  $HorsePosition[0] = tmpPosition[0].to_i + 1
  $HorsePosition[1] = tmpPosition[1].to_i + 1

  findPositions(node)
end

readFile(ARGV[0])
fillBoard()
piece = 0

puts "Horse = #{$HorsePosition}"
puts "White = #{$WhitePositions}"
puts "Black = #{$BlackPositions}"
puts

until $WhitePositions.empty? do
  until $Tree.empty? do
    moveHorse()

    if $WhitePositions.include?($Tree[-1][-1]) then
      piece += 1
      puts "Piece #{piece} = #{$Tree[-1]}"

      piecePosition = ["#{$Tree[-1][-1]}"]

      $WhitePositions.delete($Tree[-1][-1])
      $Tree.clear
      $Tree.push(piecePosition) 

      break

    end
  end
end

