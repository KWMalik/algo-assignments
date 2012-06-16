# Ruby program to count number of inversions in a given integer array.
# This program applies "incremental" approach and hence has quadratic run time
#
# (Developed for Assignment of "Algorithm: Design and Analysis - Part 1" https://www.coursera.org/course/algo


def read_array(file, count)
  int_array = []
  File.open(file) do |f|
    counter = 0
    while (l = f.gets and counter < count ) do
      int_array << l.to_i
      counter = counter + 1
    end

  end
  return int_array
end


puts "Simple Inversion Counter"

int_array = read_array("IntegerArray.txt", 100)

start = Time.now

ic = 0

i = 0
while i < int_array.size

  j = i + 1
  while j  < int_array.size do
    
    ic = ic + 1 if (int_array[i] > int_array[j]) 
    j = j + 1
  end
  
  i = i + 1
  
end

endTime = Time.now

puts "Num inversions #{ic} in #{endTime - start}"
