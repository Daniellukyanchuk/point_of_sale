class MySorter
  # The name of the algorithm is selection sort

  # Go through the array, get me the min and assign it to the "arr" variable.
  # 
  def self.selection_sort(array) 
    # Step 1: Go through the array
    # Step 2: Find the smallest element of array using get_min method
    # Step 3: Delete that smallest element from the array 
    # Step 4: Assign deleted element of array to arr.
    # Step 5: Keep doing step 1 through 4 until there is nothing left in the array.
    # Step 6: The loop should break when array is empty.
    arr = []
    while !array.empty?
        arr.push(array.delete(get_min(array))) 
    end
    return arr
  end

  def self.get_min(array)
    min = nil
  	array.each do |a|
      if min.nil?
        min = a
      elsif min > a
        min = a 
      end
    end
    return min
  end

# Making bubble_sort 
# Step 1: Go through the array. 
# Step 2: Compare next 2 elements of the array.
# Step 3: Find the smallest among those two.
# Step 4: If second element is lesser than first, swap the places.
# Step 5: If it is not, leave them as they are. 
# Step 6: Go to the next two elements.
# Step 7: Do the same with them.
# Step 8: Stop when you iterated through the whole array and it didn't swap.

  def self.bubble_sort(array)
    array_length = array.size 
    return array if array_length <= 1

    loop do 
      swapped = false
      (array_length-1).times do |i|
        if array[i] > array[i+1]
          array[i], array[i+1] = array[i+1], array[i]
          swapped = true
        end
      end
      break if not swapped
    end
    return array
  end


end