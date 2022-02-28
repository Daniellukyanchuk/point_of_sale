class MySorter
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
    arr # You can write return before arr just to that it's returning arr. 
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
    array
  end
 
  def self.hash_sort_by_value(sample_hash)
    # h = {c: 1, d: 5, e: 4, a: 2, b: 3}
    # should return [1, 2, 3, 4, 5]
    self.selection_sort(sample_hash.values)
  end

  def self.hash_sort_by_key(hash_to_sort)
    # h = {c: 1, d: 5, e: 4, a: 2, b: 3}
    # should return [2, 3, 1, 5, 4]
    sorted_keys = self.selection_sort(hash_to_sort.keys)
    
    sorted_values = []
    sorted_keys.each do |sk|
      sorted_values.push(hash_to_sort[sk])
    end
    sorted_values
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
    min
  end

  # Reverse a string using a while loop
  def self.reverse_string(word)
    word = word.chars
    # word = ['s', 'e', 'n', 't', 'e', 'n', 'c', 'e']
    reversed_word = ''
    # start at the last letter of the word
    # write down the letter
    # go to the previous letter
    # write it down
    # stop when there are no letters left
    position = word.length - 1
    # while word.length > 0
    # while !word.blank?
    # while !word.empty?
    while position >= 0
      reversed_word += word[position]
      position -= 1
    end
    reversed_word 
  end

  def self.merge_sort(array)
  # Break up the problem.
  # How to divide the array of integers into two equal arrays of integers? 
  # I have to create a loop. In that loop I have to take the array and get it's length. 
  # Divide the length in two. First half of the array divide by length assign to variable left_side, the rest should be assigned to the variable 
  # right_side. 

    sorted_arr = []
    if array.length > 1
      splitted_array = array.in_groups(2, false)
      left_array = merge_sort(splitted_array[0])
      right_array = merge_sort(splitted_array[1])

      li = 0
      ri = 0
      while li < left_array.length && ri < right_array.length
        if left_array[li] <= right_array[ri]
          sorted_arr.push(left_array[li]) 
          li += 1      
        elsif left_array[li] >= right_array[ri]
          sorted_arr.push(right_array[ri]) 
          ri += 1     
        end
      end
    
      while li < left_array.length
        sorted_arr.push(left_array[li])
        li += 1
      end

      while ri < right_array.length 
        sorted_arr.push(right_array[ri])
        ri += 1
      end
      
    else
      sorted_arr = array
    end 
    return sorted_arr
  end
  
  
  # Break up the problem.
  # How to divide the array of integers into two equal arrays of integers? 
  # I have to create a loop. In that loop I have to take the array and get it's length. 
  # Divide the length in two. First half of the array divide by length assign to variable left_side, the rest should be assigned to the variable 
  # right_side. 
  # Breaking up the problem is the complexity in quick sort. How do you break up the problem. 
  # Understand the algorithm. Understand the condition upon which you know its done. 
  # How do you break up the indencies an what is the base case? 
  # When you think of a quick sort think about the word pivot. 
  # Pivot is one of the items in the array that meets the following three conditions after we sorted it.
  # 1. Correct position in final, sorted array. 
  # 2. Items to the left are smaller. 
  # 3. Items to the right are larger. 

  # Step 1: Choose a pivot. 
  # Step 2: Move the pivot to the end of the array to get it out of the way. 
  # Step 3: We are gonna look for two items. 
  # 1. itemFromLeft that is larger than pivot. 
  # 2. itemFromRight that is smaller than pivot. 
  # If the item from left is larger than the pivot and the item from right, swap item from left with right. 
  # Keep swapping items in that way. 
  # Stop when index of itemFromLeft > index of itemFromRight. 
  # Step 4: Swap the last item from left with the pivot. 
  # Our pivot is now in the correct spot. 
  # It's in the correct spot when all the items from the left are smaller and all items from the right are larger. 
  # Quick sort is recursive, method calls itself. 
  # Step 5: We take all the itemsFromRight. Implement the same method to the itemsFromRight. 
  # How do we choose the pivot? Median-of-three. 
  # In this method we look at the first, middle and last elements of the array.
  # We sort them properly and choose the middle item as our pivot.

  # Quicksort(A as array, low as int, high as int)
  #   if (low < high)
  #     pivot_location = Partition (A, low, high)
  #     Quicksort(A, low, pivot_location)
  #     Quicksort(A, pivot_location + 1, high)

  # Partition(A as array, low as int, high as int)
  #   pivot = A[low]
  #   leftwall = low

  #   for i = low + 1 to high
  #     if (A[i] < pivot) then 
  #       swap (A[i], A[lefwall])
  #       leftwall = leftwall + 1


  #   swap(pivot, A[leftwall])

  #   return(leftwall)
  # Does:
   # Groups everything according to the pivot.
   # Gets the index of the pivot. 
  # Takes: 
   # Takes the array you want to partition. The starting point of that array and the ending point. 
  # Returns: 
    # Tells you the position of the pivot. 
  def self.partition(array, left, right)
    
    pivot_value = array[array.length - 1]

    while left < right  
      while array[left] <= pivot_value
        left += 1
   
      end

      while array[right] > pivot_value
        right -= 1
      end

      if array[left] > array[right] 
        swap(array, left, right)
      end

    end
    swap(array, left, array.length - 1)
    pivot_index = left 

    return pivot_index
  end
  # Does:
    # It sorts an array between the left and right indexes.
  # Takes: 
    # It takes three arguments.
    # Array is the array to be sorted. 
    # It will start sorting from the left_index.
    # It will sort up to the right_index. 
  # Returns: 
    # Returns the sorted array. 
  def self.quick_sort(array, left_index, right_index)

    if left_index < right_index 

      j = partition(array, left_index, right_index)
  
      quick_sort(array, left_index, j-1)

      quick_sort(array, j+1, right_index)

    end
    
    return array

  end

  def self.swap(arr, p1, p2)
    arr[p1], arr[p2] = arr[p2], arr[p1]
  end

  def self.find_deepest(arr, depth=0)
  # 3 Laws of Recursion
  # A recursive algorithm must call itself, recursively.
  # A recursive algorithm must have a base case.
  # A recursive algorithm must change its state and move toward the base case.
  # tmp = [['1a'], ['1b', ['2a']], ['1c', '1d', ['2b'], ['2c', '2d', ['3a']]], [[['3b']]]]

  # Step 1: How to reduce the problem. 
  # Step 2: How do I recognize that the problem can't be broken down anymore. That's gonna be the base case. 
  # Step 3: Once it's down on the simplest version it's gonna go back, how to merge the result. 
  # Step 4: A clear example of what the method should return. Write out a sample problem and a sample of what it should return. 

  # Example of the method
  # Takes the array of arrays tmp = [['1a'], ['1b', ['2a']], ['1c', '1d', ['2b'], ['2c', '2d', ['3a']]], [[['3b']]]]
  # Goes through the array of arrays and looks for the depth=1 first time, then depth=2 second time and keeps doing it until reaches the deepest (['3a']) and ['3b']. 
  # Returns the deepest. If there are several elements on the same depth, returns all of them (['3a'], ['3b']).

    deepest_val = {depth: depth, values: []}
    arr.each do |a|
      if a.kind_of?(Array)
         dep = find_deepest(a, depth + 1)
           if dep[:depth] > deepest_val[:depth]
             deepest_val = dep
           else dep[:depth] == deepest_val[:depth]
              deepest_val[:values] += dep[:values]
           end
      else
        deepest_val[:values].push a
      end
    end
    return deepest_val
  end
end