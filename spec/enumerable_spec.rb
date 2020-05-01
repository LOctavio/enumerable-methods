require './enumerable.rb'

describe Enumerable do
  describe '#my_each' do
    it 'return an array' do
      expect([1, 2, 3, 4].my_each { |x| print x }).to eql([1, 2, 3, 4])
    end
  end
  describe '#my_each_with_index' do
    it 'all the values has an index' do
      hash = {}
      [1, 2, 3, 4].my_each_with_index { |val, index| hash[val] = index }
      expect(hash).to eql({ 1 => 0, 2 => 1, 3 => 2, 4 => 3 })
    end
  end
  describe '#my_select' do
    it 'selected values are multiple of three' do
      expect([1, 2, 3, 4, 5, 6, 7, 8, 9].my_select { |x| (x % 3).zero? }).to eql([3, 6, 9])
    end
    it 'selected values are multiple of two' do
      expect([1, 2, 3, 4, 5, 6, 7, 8, 9].my_select { |x| (x % 2).zero? }).to eql([2, 4, 6, 8])
    end
  end
  describe '#my_all?' do
    it 'all the values are bigger or equal than 3' do
      expect([8, 4, 3, 9, 5].my_all? { |x| x >= 3 }).to eql(true)
    end
    it 'all the values are not bigger or equal than 4' do
      expect([8, 4, 3, 9, 5].my_all? { |x| x >= 4 }).to eql(false)
    end
  end
end
