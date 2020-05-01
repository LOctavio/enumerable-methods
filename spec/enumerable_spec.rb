require './enumerable.rb'

describe Enumerable do
  describe '#my_each' do
    it 'return an array' do
      expect([1,2,3,4].each { |x| print x }).to eql([1, 2, 3, 4])
    end
  end
end