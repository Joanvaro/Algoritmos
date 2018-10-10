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
    if $criptedMessage[x + $index].size != keyArray[x].size then
			puts "NO SE ENCONTRO SOLUCION"
			exit(1)
		end
    
    (0...keyArray[x].size).each do |char|
      unless $dictionary.has_key?($criptedMessage[x + $index][char]) then
        $dictionary[$criptedMessage[x + $index][char]] = keyArray[x][char]
      end
    end
  end

  (0...keyArray.size).each do |key|
    $criptedMessage.delete_at($index)
  end

  return keyArray
	
end

def decodeMessage()
	realMessage = String.new
	message = $criptedMessage.join(" ")
	
	message.each_char do |c|
		if c == " " then
			realMessage.insert(-1, " ")
		else
			realMessage.insert(-1, $dictionary[c])
		end
	end
	puts realMessage
end	

cases = readFile(ARGV[0])

cases.to_i.times do |paraghrap|
  #TODO: get the message by parragrahp
  key = getDictionary()
  decodeMessage()
end
