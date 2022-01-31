# Use let and before hooks in your rspec tests, in order to clean up your specs and remove duplication.
require 'sandwich'

describe Sandwich do 
	context 'when the sandwich should be vegan' do 
      # let(:sandwich) { Sandwich.new(false, false, ['lettuce', 'tomato', 'mustard'])}

      it 'should not have meat' do 
      	expect(vegan_sandwich.meat).to eq(false)
      end


      it 'should not have cheese' do 
      	expect(vegan_sandwich.cheese).to eq(false)
      end

      it 'should not have mayonaise' do 
      	expect(vegan_sandwich.condiments).to_not include('mayonaise')
      end
    end
    
    context 'when the sandwich should not be vegan' do 
      before(:each) do  
      	@sandwich = Sandwich.new(true, true, ['lettuce', 'tomato', 'mayonaise'])
      end

      it 'should have meat' do 
        expect(@sandwich.meat).to be(true)
      end

      it 'should have cheese' do 
      	expect(@sandwich.cheese).to be(true)
      end

      it 'should have mayonaise' do 
        expect(@sandwich.condiments).to include('mayonaise')
      end
    end
end

def vegan_sandwich
	Sandwich.new(false, false, ['lettuce', 'tomato', 'mustard'])
end