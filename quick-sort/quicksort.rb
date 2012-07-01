# Ruby program to perform quick sort on a given array.  The array is read from a test input file, QuickSort.txt.
# This program prints the number of comparisons done in a quick sort implementation for following three conditions:
#   a) When pivot is first element of the array
#   b) When pivot is last element of the array#
#   c) When pivot is the median of the first, middle and last element of the array.
#
# (Developed for Assignment of "Algorithm: Design and Analysis - Part 1" https://www.coursera.org/course/algo
# Author: Srikanth P Shreenivas

def partition(array, left_index, right_index)

  pivot = array[left_index]
  pivot_pos = left_index

  for j in (left_index+1..right_index)
    if (array[j] <= pivot)
      array[pivot_pos + 1], array[j] = array[j], array[pivot_pos + 1]
      pivot_pos = pivot_pos + 1
    end
  end

  array[left_index], array[pivot_pos] = array[pivot_pos], array[left_index]

  elements_left_of_pivot = pivot_pos-1 < 0 ? [] : array[0..pivot_pos - 1]
  pivot_element = array[pivot_pos .. pivot_pos]
  elements_right_of_pivot = array[pivot_pos+1..right_index];

  return elements_left_of_pivot, pivot_element, elements_right_of_pivot
end

def sort(array, pivot_pos_finder_lambda)

 if (array.length <= 1)
    return array, 0
 end
 
 pivot_pos = pivot_pos_finder_lambda.call(array)
 #p array
 #p array.length
 #p pivot_pos
 if (pivot_pos == nil) then
  puts "-----"
  p array
 end
 
 array[0], array[pivot_pos] = array[pivot_pos], array[0]
  
 left, pivot, right = partition(array, 0, array.length-1)
 
 sorted_left, left_comparisons = sort(left, pivot_pos_finder_lambda);
 sorted_right, right_comparisons = sort(right, pivot_pos_finder_lambda);
 
 return sorted_left.concat(pivot).concat(sorted_right), (array.length - 1 + left_comparisons + right_comparisons)
end

# Reads 'count' number of integers from the file
def read_array(file, count)
  int_array = []
  File.open(file) do |f|
    counter = 0
    while (l = f.gets and counter < count) do
      int_array << l.to_i
      counter = counter + 1
    end
  end
  return int_array
end



puts "Quick Sort Implementation"
int_array = read_array("QuickSort.txt", 10000)

sorted_array, num_comparisons = sort(Array.new(int_array), lambda{|x| 0})
puts "Num comparisons when using first element as pivot: #{num_comparisons}"

sorted_array, num_comparisons = sort(Array.new(int_array), lambda{|x| x.length - 1})
puts "Num comparisons when using last element as pivot: #{num_comparisons}"

# Method to find median index as per problem specification
median_index_finder = lambda do |x|
  middle_index = (x.length%2 == 0) ? x.length/2 - 1: x.length/2

  first_element = x[0]
  middle_element = x[middle_index]
  last_element = x[x.length - 1]

  if ( (first_element >= middle_element and first_element <= last_element) or 
       (first_element <= middle_element and first_element >= last_element)) then
      median_index = 0
  elsif ((middle_element >= first_element and middle_element <= last_element) or
         (middle_element <= first_element and middle_element >= last_element))
         median_index = middle_index
  elsif ((last_element >= first_element and last_element <= middle_element) or
         (last_element <= first_element and last_element >= middle_element))
         median_index = x.length - 1
  end

  return  median_index
end

sorted_array, num_comparisons = sort(Array.new(int_array), median_index_finder)
puts "Num comparisons when using median-of-three element as pivot: #{num_comparisons}"
