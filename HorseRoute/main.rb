#!/usr/bin/ruby

$HorsePosition = Array.new
$WhitePositions = Array.new
$BlackPositions = Array.new
$Board = Array.new(8) { Array.new(8) }

def readFile(filename)
  data = File.readlines(filename)
  data.collect! { |x| x.delete("\n") }
	
  $HorsePosition = data.delete_at(0).split(',')
  $WhitePositions = data.delete_at(0).split(',')
  $BlackPositions =  data.delete_at(0).split(',')
	
end

def isInsideBoard(x,y,n)
  return (x >= 1 and x <= n and y >= 1 and y <= n) ? true : false
end

def fillBoard()
  # Fill white pieces
  count = $WhitePositions.size() / 2
  count.times do |val|
    $Board[$WhitePositions[2*val+1].to_i - 1][$WhitePositions[2*val].to_i - 1] = "W"
  end

  # Fill black pieces
  count = $BlackPositions.size() / 2
  count.times do |val|
    $Board[$BlackPositions[2*val+1].to_i - 1][$BlackPositions[2*val].to_i - 1] = "B"
  end
  
end

def moveHorse()
  dx = [-2,-1,1,2,-2,-1,1,2]
  dy = [-1,-2,-2,-1,1,2,2,1]

  movements = Array.new
  movements.push($HorsePosition[0].to_i)
  movements.push($HorsePosition[1].to_i)

  $Board[movements[1].to_i - 1][movements[0].to_i - 1] = "X"

  dx.size().times do |mov|
    tmpX = movements[0] + dx[mov] - 1
    tmpY = movements[1] + dy[mov] - 1

    if ( isInsideBoard(tmpX,tmpY,8) and ($Board[tmpY][tmpX] != "B") ) then
      $Board[tmpY][tmpX] = "S"
      #puts "x = #{tmpX}, y = #{tmpY}"
    end
  end
end

readFile(ARGV[0])
puts "Horse = #{$HorsePosition}"
puts "White = #{$WhitePositions}"
puts "Black = #{$BlackPositions}"

puts isInsideBoard(4,9,8)
fillBoard()
moveHorse()

$Board.each { |x| puts "#{x}" }
