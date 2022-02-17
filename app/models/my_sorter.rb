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

  def merge_sort(array)


  end

  def find_deepest(arr, depth=0)
  # 3 Laws of Recursion
  # A recursive algorithm must call itself, recursively.
  # A recursive algorithm must have a base case.
  # A recursive algorithm must change its state and move toward the base case.
  # tmp = [['1a'], ['1b', ['2a']], ['1c', '1d', ['2b'], ['2c', '2d', ['3a']]], [[['3b']]]]
    result = {depth: depth, values: []}

    arr.each do |a|
      if a.kind_of?(Array)

      else
        result[:values].push a 
      end
    end

    return result
    
  end
end