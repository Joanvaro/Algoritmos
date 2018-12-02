#! /usr/bin/ruby

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

list = [34,64,12,25,99,23,1,4,67,4]
puts "Original list = #{list}"

list1 = bubbleSort(list)
puts "Bubble Sorted list = #{list1}"
list = [34,64,12,25,99,23,1,4,67,4]
puts "Bubble Sorted list = #{list}"

list2 = insertionSort(list)
puts "Insertion Sorted list = #{list2}"
list = [34,64,12,25,99,23,1,4,67,4]
puts "Insertion Sorted list = #{list}"

list3 = quickSort(list, 0, list.size - 1)
puts "Quick Sorting list = #{list}"
