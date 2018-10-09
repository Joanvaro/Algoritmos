#!/usr/bin/ruby

$criptedMessage = Array.new
$dictionary = Hash.new

$keyMessage = "el veloz murciélago hindú comía feliz cardillo y kiwi cuando la cigüeña tocaba el saxofón detrás del palenque de paja"

def readFile(fileName)
  data = File.open(fileName.to_s, "r") 
  
  data.each_line do |line|
    $criptedMessage.push(line)
  end

  numberOfCases = $criptedMessage.delete_at(0)
  return numberOfCases
end

def getDictionary()
  keyArray = Array.new
  sizeArray = Array.new

  keyArray = $keyMessage.split(" ")

  keyArray.each do |val|
    sizeArray.push(val.size)
  end

  biggerWord = sizeArray.sort.pop() 

  $criptedMessage.map! {|x| x.split(" ")}
  $criptedMessage.flatten!

  $criptedMessage.each do |msg|
    if msg.size == biggerWord then
      $index = $criptedMessage.index(msg) - 2 
      break
    end
  end

  (0...keyArray.size).each do |x|
    puts "Error" if $criptedMessage[x + $index].size != keyArray[x].size
    
    (0...keyArray[x].size).each do |char|
      unless $dictionary.has_key?(keyArray[x][char]) then
        $dictionary[keyArray[x][char]] = $criptedMessage[x + $index][char]
      end
    end
  end

  puts "$criptedMessage[#{$index}] = #{$criptedMessage[$index]}"

  return keyArray
end

cases = readFile("message.txt")
key = getDictionary()
puts $dictionary
