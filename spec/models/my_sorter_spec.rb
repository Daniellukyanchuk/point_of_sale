require 'rails_helper'

RSpec.describe MySorter, type: :model do
  it "should sort an array of items in ascending or descending order, ascending by default" do

      #create mock array
      sample_array = [3, 8, 5, 2, 10]

      #call sort array method w/ sample data
      MySorter.sort_array(sample_array)   

      expect.sample_array.to eq([2, 3, 5, 8, 10])
  end
end
