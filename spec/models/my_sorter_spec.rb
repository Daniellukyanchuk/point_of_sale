require 'rails_helper'

RSpec.describe MySorter, type: :model do
  it "should sort an array of items in ascending order" do

      #create mock array
      sample_array = [3, 8, 5, 2, 10]

      #call sort array method w/ sample data
      select_sorted = MySorter.selection_sort(sample_array) 

      expect(select_sorted).to eq([2, 3, 5, 8, 10])
  end

  it "should return the smallest number or string in an array" do

      #create mock array
      sample_array = [3, 8, 5, 2, 10]

      #call sort array method w/ sample data
      min = MySorter.get_min(sample_array) 

      expect(min).to eq(2)
  end

  it "should sort an array of items in ascending order " do

      #create mock array
      sample_array = [3, 8, 5, 2, 10]

      #call sort array method w/ sample data
      bubble_sorted = MySorter.bubble_sort(sample_array) 

      expect(bubble_sorted).to eq([2, 3, 5, 8, 10])
  end

  it "should sort the values of a hash by value in ascending order " do

      #create mock array
      sample_hash =  {a: 2, b: 3, c: 1, d: 5, e: 4}

      #call sort array method w/ sample data
      sorted_hash = MySorter.value_sort(sample_hash) 

      expect(sorted_hash).to eq( [1,2,3,4,5])
  end

  it "should sort values of a hash by key of a hash in ascending order " do

      #create mock array
      sample_hash =  {c: 1, d: 5, e: 4, a: 2, b: 3} 

      #call sort array method w/ sample data
      key_sorted = MySorter.key_sort(sample_hash) 

      expect(key_sorted).to eq( [2, 3, 1, 5, 4])
  end

  it "should reverse the order or the word" do

      #create mock array
      sample_word = "zebra"      

      #call sort array method w/ sample data
      reversed_word = MySorter.reverse_string(sample_word) 

      expect(reversed_word).to eq("arbez")
  end

  it "should find the deepest element(s) and return its depth and value(s)" do

      #create mock array
      tmp = [['1a'], ['1b', ['2a']], ['1c', '1d', ['2b'], ['2c', '2d', ['3a']]], [[['3b']]]]
      

      #call sort array method w/ sample data
      deepest_element = MySorter.dig_deeper(tmp)

      expect(deepest_element).to eq({depth: 3, values: ["3a", "3b"]})
  end

  it "should sort the array in ascending order" do

      #create mock array
      tmp = [2,5,7,8,1,10,9,3,4,6]
      

      #call sort array method w/ sample data
      sorted_array = MySorter.merge_sort(tmp)

      expect(sorted_array).to eq([1,2,3,4,5,6,7,8,9,10])
  end

  it "should sort the array in ascending order" do

      #create mock array
      tmp = [2,10,7,8,1,4,9,3,5,6]
      arr2 = [2,10,7,8,1,4,2,3,5,2]
      
      #call sort array method w/ sample data
      sorted_array = MySorter.quick_sort(tmp)

      expect(sorted_array).to eq([1,2,3,4,5,6,7,8,9,10])

      sorted_array2 = MySorter.quick_sort(arr2)
      
      expect(sorted_array2).to eq([1,2,2,2,3,4,5,7,8,10])

      # arr3 = Array.new(10000) {rand(1..20)}
      # expect(MySorter.quick_sort(arr3)).to eq(arr3.sort)
  end
end
