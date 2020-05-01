require './enumerable.rb'

describe Enumerable do
  describe '#my_each' do
    it 'return an array' do
      expect([1,2,3,4].my_each { |x| print x }).to eql([1, 2, 3, 4])
    end
  end
  describe "#my_each_with_index" do
    it "" do
      hash = Hash.new
      [1, 2, 3, 4].my_each_with_index { |val,index| hash[val]=index }
      expect( hash ).to eql({1 => 0, 2=>1, 3 => 2, 4 => 3})
    end
  end
end