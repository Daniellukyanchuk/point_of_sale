require 'rails_helper'

RSpec.describe MySorter, type: :model do

  it "it takes an array of either integers or string and sorts them by default ascending" do  
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
end
