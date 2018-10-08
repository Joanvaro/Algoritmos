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
  keyArray = $keyMessage.split(" ")

  return keyArray
end

cases = readFile("message.txt")
key = getDictionary()

puts cases
puts key
