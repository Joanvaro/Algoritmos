#!/usr/bin/ruby

$criptedMessage = Array.new
$dictionary = Hash.new

$keyMessage = "el veloz murciélago hindú comía feliz cardillo y kiwi cuando la cigüeña tocaba el saxofón detrás del palenque de paja"

def readFile(fileName)
	message = Array.new
  data = File.open(fileName.to_s, "r") 
  
  data.each_line do |line|
    message.push(line)
  end

  numberOfCases = message.delete_at(0)
	str = message.join
	msgArray = str.split(/^$\n/)

	(0...numberOfCases.to_i).each do |cases|
		$criptedMessage[cases] = Array.new
		$criptedMessage[cases] = msgArray[cases].split(" ")
	end

  return numberOfCases
end

def getDictionary(entry)
  keyArray = Array.new
  sizeArray = Array.new

  keyArray = $keyMessage.split(" ")

  keyArray.each do |val|
    sizeArray.push(val.size)
  end

  biggerWord = sizeArray.sort.pop() 

  $criptedMessage[entry].map! {|x| x.split(" ")}
  $criptedMessage[entry].flatten!

  $criptedMessage[entry].each do |msg|
    if msg.size == biggerWord then
      $index = $criptedMessage[entry].index(msg) - 2 
      break
    end
  end

  (0...keyArray.size).each do |x|
    if $criptedMessage[entry][x + $index].size != keyArray[x].size then
			puts "NO SE ENCONTRO SOLUCION"
			return nil
		end
    
    (0...keyArray[x].size).each do |char|
      unless $dictionary.has_key?($criptedMessage[entry][x + $index][char]) then
        $dictionary[$criptedMessage[entry][x + $index][char]] = keyArray[x][char]
      end
    end
  end

  (0...keyArray.size).each do |key|
    $criptedMessage[entry].delete_at($index)
  end

  return keyArray
	
end

def decodeMessage(entry)
	realMessage = String.new
	message = $criptedMessage[entry].join(" ")
	
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
  key = getDictionary(paraghrap)
	unless key == nil then
  	decodeMessage(paraghrap)
	end
end
