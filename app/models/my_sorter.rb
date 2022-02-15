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
 



end