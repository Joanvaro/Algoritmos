#!/usr/bin/ruby

$HorsePosition = Array.new
$WhitePositions = Array.new
$BlackPositions = Array.new
$Board = Array.new(8) { Array.new(8) }

def readFile(filename)
  coordinates = Array.new 
	
  data = File.readlines(filename)
  data.collect! { |x| x.delete("\n") }
	
  $HorsePosition = data.delete_at(0).split(',')
  $WhitePositions = data.delete_at(0).split(',')
  $BlackPositions =  data.delete_at(0).split(',')
	
end

def isInsideBoard(x,y,n)
  return (x >= 1 and x <= n and y >= 1 and y <= n) ? true : false
end

def moveHorse()
  dx = [-2,-1,1,2,-2,-1,1,2]
  dy = [-1,-2,-2,-1,1,2,2,1]

  movements = Array.new
  movements.push($HorsePosition[0].to_i)
  movements.push($HorsePosition[1].to_i)

  $Board[movements[1].to_i - 1][movements[0].to_i - 1] = "X"

  dx.size().times do |mov|
    tmpX = movements[0] + dx[mov]
    tmpY = movements[1] + dy[mov]

    $Board[tmpY - 1][tmpX - 1] = "S"
    #puts "x = #{tmpX}, y = #{tmpY}"
  end
end

readFile(ARGV[0])
puts "Horse = #{$HorsePosition}"
puts "White = #{$WhitePositions}"
puts "Black = #{$BlackPositions}"

puts isInsideBoard(4,9,8)
moveHorse()

$Board.each { |x| puts "#{x}" }
