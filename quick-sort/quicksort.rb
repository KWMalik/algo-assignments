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


def sort(array, pivot_pos)

 if (array.length <= 1)
    return array, 0
 end
 
 array[0], array[pivot_pos] = array[pivot_pos], array[0]
  
 left, pivot, right = partition(array, 0, array.length-1)
 
 sorted_left, left_comparisons = sort(left, 0);
 sorted_right, right_comparisons = sort(right, 0);
 
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



int_array = [3,4,1,2,0, 5,6,1,1,1,1]
p sort(int_array, 0)


puts "Quick Sort Implementation"
int_array = read_array("QuickSort.txt", 10000)

p sort(int_array, 0)

