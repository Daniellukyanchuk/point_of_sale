class MySorter < ApplicationRecord

	def self.selection_sort(unsorted_array)

		sorted_array = []
		arr = unsorted_array		

		while arr.length > 0 
			sorted_array.push(get_min(arr))
			arr.delete(get_min(arr))
		end

		return sorted_array
	end

	def self.get_min(some_array)

		cur_min = nil
		
		some_array.each do |item|
			if cur_min.nil?
				cur_min = item
			elsif cur_min > item
				cur_min = item
			end		
		end
		return cur_min
	end 

	def self.bubble_sort(unsorted_array)

		arr = unsorted_array
		n = arr.length	

			loop do
				changed = false	
				
				(n-1).times do |j| 
					if 	arr[j] > arr[j + 1]
						arr[j], arr[j + 1] = arr[j + 1], arr[j]
						changed = true
					end
				end
				break if not changed
			end
		arr
	end

	def self.value_sort(unsorted_hash)
		selection_sort(unsorted_hash.values)		
	end

#   {c: 1, d: 5, e: 4, a: 2, b: 3}


	def self.key_sort(unsorted_hash)

		sorted_keys = selection_sort(unsorted_hash.keys)
		sorted_values = []

		sorted_keys.each do |sv|
			sorted_values.push(unsorted_hash[sv])			
		end
		sorted_values
	end


	def self.reverse_string(some_string)

		some_string = "zebra"
		arr = some_string.chars 

		reversed_string = []

		position = arr.length - 1
		while position >= 0 
			reversed_string.push(arr[position])
			position -= 1
		end

	# 	while arr.length > 0 
	# 		reversed_string.push(arr.pop)
	# 	end
		reversed_string.join("")
	end



	# def self.find_deepest(arr, depth=0)
	# 	dig_results = []
	# 		arr.each do |fd|		
	# 		dig_results.push(dig_deeper(arr, 0))
	# 		end
	# 	dig_results
	# end

	

	def self.dig_deeper (arr, depth=0)

		deepest = {depth: depth, values: []}

			arr.each do |dd|

				if dd.class == Array				
					result = dig_deeper(dd, depth + 1)
					if result[:depth] > deepest[:depth]
						deepest = result
					elsif result[:depth] = deepest[:depth]
						deepest[:values] += result[:values]
						
					end
				else
					deepest[:values].push(dd)
				end	
				
			end

		return deepest
		
	end

	def self.merge_sort(arr)

		sorted_array = []

		if arr.length > 1
			split_arr = arr.in_groups(2, false)

			left_sorted_array = merge_sort(split_arr[0])
			right_sorted_array = merge_sort(split_arr[1])
			
			x = 0
			j = 0
			while x <= left_sorted_array.length - 1 && j <= right_sorted_array.length - 1

				if left_sorted_array[x] <= right_sorted_array[j]
					sorted_array.push(left_sorted_array[x])
					x += 1
				else 
					sorted_array.push(right_sorted_array[j])
					j += 1
				end			
			end

			while j <= right_sorted_array.length - 1
				sorted_array.push(right_sorted_array[j])
				j += 1
			end

			while x <= left_sorted_array.length - 1
				sorted_array.push(left_sorted_array[x])
				x += 1
			end

		else 
			sorted_array = arr
		end
		
		return sorted_array
	end

	 
	# What does it do?
	# What does it take?
	# it returns the final position (index) of the pivot

	def self.partition(arr, start_index, end_index)

		left = start_index + 1
		right = end_index
		piv_val = arr[start_index]
		
		while left <= right 
			
			if  arr[left] >= piv_val && arr[right] <= piv_val 
				arr[left], arr[right] = arr[right], arr[left]
				left += 1
				right -= 1
			elsif arr[left] < piv_val
				left += 1
			elsif arr[right] > piv_val
				right -= 1
			end				
		end
		
		piv_index = right
		arr[start_index], arr[right] = arr[right], arr[start_index]
		
		return piv_index
	end

	
	# sorts an array between the left and right index
	# 	takes three arguments - array (to be sorted), left (starting position), right (end position)
	# Returns the sorted array

	def self.quick_sort(arr, left = 0, right = arr.length-1) 

		if left < right
			piv_index = partition(arr, left, right)
			#returns piv_index
			
			quick_sort(arr, left, piv_index - 1)
			quick_sort(arr, piv_index + 1, right)
			
		end 

		return arr
	end
		
end

# a clear exampe of what the method should return
# how to reduce the problem (moving towards base case)	
# how do you recognize when the problem can't be broken down anymore (how do you know you're at basecase)
# how to merge the results

# compare first item of left_sorted_array with first item of right_sorted_array
# if left is smaller, add it to sorted array 
# then compare second item in left to first item in right_sorted_array
# if right is smaller, add it to sorted array


                  