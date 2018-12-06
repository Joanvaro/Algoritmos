#! /usr/bin/ruby

require 'time'

startTime = Time.now

def readFile(filename)
  data = File.readlines(filename)
  $DataArray = data[0].split(" ")

  $DataArray.collect! { |x| x.to_i }
end

def bubbleSort(list)
  return list if list.size <= 1
  swapped = true

  while(swapped) do
    swapped = false
    0.upto(list.size - 2) do |i|
      if(list[i] > list[i+1]) then
        list[i], list[i+1] = list[i+1], list[i] # swapping values
        swapped = true
      end
    end
  end

  return list
end

def insertionSort(list)
  return list if list.size <= 1

  1.upto(list.size - 1) do |i|
    key = list[i]
    j = i - 1

    while (j >= 0 and key < list[j]) do
      list[j+1], list[j] = list[j], list[j+1]
      j -= 1
    end
  end  
  return list
end

def partition(list, left_index, right_index)
  pivot = left_index
  i = left_index

  while i < right_index do
    if list[i] <= list[right_index]
      list[i], list[pivot] = list[pivot], list[i]
      pivot += 1
    end
    i += 1
  end

  list[right_index], list[pivot] = list[pivot], list[right_index]
  pivot
end

def quickSort(list, left_index = 0, right_index = nil)
  return [] if list.empty?

  if right_index == nil then
    right_index = list.length - 1
  end

  if left_index < right_index then
    pivot = partition(list, left_index, right_index)

    quickSort(list, left_index, pivot - 1)
    quickSort(list, pivot + 1, right_index)
  end

  list
end

readFile(ARGV[0])

puts "Original Array = #{$DataArray}"

case ARGV[1]
when "bubble"
  list = bubbleSort($DataArray)
when "insertion"
  list = insertionSort($DataArray)
when "quick"
  list = quickSort($DataArray)
end

endTime = Time.now

puts "Sorted Array = #{list}"
puts
puts "Total Time of execution #{endTime - startTime} seconds"
