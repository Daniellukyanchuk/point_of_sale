require 'rails_helper'

RSpec.describe MySorter, type: :model do

  it "it takes an array of either integers or string and sorts them using selection_sort" do  
    aa = [9, 3, 6, 2, 5]
    b = MySorter.selection_sort(aa)
    # c = MySorter.new
    # c.sort_me(aa)
    expect(b).to eq([2, 3, 5, 6, 9])
  end

  it "takes an array and returns smallest element in the array" do  
    aa = [9, 3, 6, 2, 5]

    b = MySorter.get_min(aa)

    expect(b).to eq(2)
  end

  it "takes an array and returns sorts it smallest to biggest using bubble_sort" do 
    array = [5, 9, 3, 4, 8, 7, 6, 2, 1]

    ar = MySorter.bubble_sort(array)

    expect(ar).to eq([1, 2, 3, 4, 5, 6, 7, 8, 9])

  end
end
