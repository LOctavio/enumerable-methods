require './enumerable.rb'

describe Enumerable do
  describe '#my_each' do
    it 'return an array' do
      expect([1, 2, 3, 4].my_each { |x| print x }).to eql([1, 2, 3, 4])
    end

    it 'return an enumerator if there is no block' do
      expect([1, 2, 3, 4].my_each).to be_an(Enumerator)
    end
  end

  describe '#my_each_with_index' do
    it 'all the values has an index' do
      hash = {}
      [1, 2, 3, 4].my_each_with_index { |val, index| hash[val] = index }
      expect(hash).to eql({ 1 => 0, 2 => 1, 3 => 2, 4 => 3 })
    end

    it 'return an enumerator if there is no block' do
      expect([1, 2, 3, 4].my_each_with_index).to be_an(Enumerator)
    end
  end

  describe '#my_select' do
    it 'selected values are multiple of three' do
      expect([1, 2, 3, 4, 5, 6, 7, 8, 9].my_select { |x| (x % 3).zero? }).to eql([3, 6, 9])
    end

    it 'selected values are multiple of two' do
      expect([1, 2, 3, 4, 5, 6, 7, 8, 9].my_select { |x| (x % 2).zero? }).to eql([2, 4, 6, 8])
    end

    it 'return an enumerator if there is no block' do
      expect([1, 2, 3, 4, 5, 6, 7, 8, 9].my_select).to be_an(Enumerator)
    end
  end

  describe '#my_all?' do
    it 'all the values are greater or equal than 3' do
      expect([8, 4, 3, 9, 5].my_all? { |x| x >= 3 }).to eql(true)
    end

    it 'all the values are not greater or equal than 4' do
      expect([8, 4, 3, 9, 5].my_all? { |x| x >= 4 }).to eql(false)
    end

    it 'all the values are not equal than 5' do
      expect([8, 4, 3, 9, 5].my_all?(5)).to eql(false)
    end

    it 'all the values are equal than 1' do
      expect([1, 1, 1, 1, 1].my_all?(1)).to eql(true)
    end

    it 'all the values are numbers' do
      expect([8, 4, 3, 9, 5].my_all?(Numeric)).to eql(true)
    end

    it 'all the values are not Strings' do
      expect([8, 4, 3, 9, 5].my_all?(String)).to eql(false)
    end

    it 'all the values have a letter \'a\' inside' do
      expect(%w[car bar chair].my_all?(/a/)).to eql(true)
    end

    it 'all the values do not have a letter \'h\' inside' do
      expect(%w[car bar chair].my_all?(/h/)).to eql(false)
    end

    it 'none of the items are nil or false' do
      expect([45, 67, 20, 9].my_all?).to eql(true)
    end

    it 'one of the items is false or nil' do
      expect([nil].my_all?).to eql(false)
    end
  end

  describe '#my_any?' do
    it 'at least one of the values is greater or equal than 3' do
      expect([8, 4, 3, 9, 5].my_any? { |x| x >= 3 }).to eql(true)
    end

    it "there isn't any value greater or equal than 10" do
      expect([8, 4, 3, 9, 5].my_any? { |x| x >= 10 }).to eql(false)
    end

    it 'at least one of the values is equal than 8' do
      expect([8, 'd', 'e', 9, 5].my_any?(8)).to eql(true)
    end

    it "there isn't any value equal than 1" do
      expect([3, 4, 5, 6, 7].my_any?(1)).to eql(false)
    end

    it 'at least one of the values has a letter \'h\' inside' do
      expect(%w[car bar chair].my_any?(/h/)).to eql(true)
    end

    it 'at least one of the values do not have a letter \'y\' inside' do
      expect(%w[car bar chair].my_any?(/y/)).to eql(false)
    end

    it 'at least one of the items is not nil or false' do
      expect([45, 67, 20, nil].my_any?).to eql(true)
    end

    it 'all the items are nil' do
      expect([nil].my_any?).to eql(false)
    end

    it 'at least one of the items is not nil or false' do
      expect([45, 67, 20, nil].my_any?.class).to eql(TrueClass)
    end

    it 'all the items are nil' do
      expect([nil].my_any?.class).to eql(FalseClass)
    end
  end

  describe '#my_none?' do
    it 'the numbers are not negative' do
      expect([20, 3, 6, 10].my_none? { |x| x < 0 }).to eql(true)
    end

    it 'the numbers are not positive' do
      expect([20, 3, 6, 10].my_none? { |x| x > 0 }).to eql(false)
    end

    it 'there is not a number 7 inside the array' do
      expect([20, 3, 6, 10].my_none?(7)).to eql(true)
    end

    it 'there is a number 6 inside the array' do
      expect([20, 3, 6, 10].my_none?(6)).to eql(false)
    end

    it 'none of the values has a letter \'y\' inside' do
      expect(%w[car bar chair].my_none?(/y/)).to eql(true)
    end

    it 'at least one of the values have a letter \'h\' inside' do
      expect(%w[car bar chair].my_none?(/h/)).to eql(false)
    end

    it 'none of the items is true' do
      expect([45, 67, 20, 9].my_none?).to eql(true)
    end

    it 'one of the items is true' do
      expect([true].my_none?).to eql(false)
    end

    it 'none of the items is true' do
      expect([45, 67, 20, 9].my_none?.class).to eql(TrueClass)
    end

    it 'one of the items is true' do
      expect([true].my_none?.class).to eql(FalseClass)
    end
  end

  describe '#my_count' do
    it 'all numbers that are equal to 3 are counted' do
      expect([20, 3, 6, 10].my_count { |x| x == 3 }).to eql(1)
    end

    it 'all numbers that are equal to 5 are counted' do
      expect([20, 3, 6, 10].my_count(5)).to eql(0)
    end

    it 'all element are in array are counted' do
      expect([20, 3, 6, 10].my_count).to eql(4)
    end
  end

  describe '#my_map' do
    it 'all the number are multiplied by 2' do
      expect([20, 3, 6, 10].my_map { |x| x * 2 }).to eql([40, 6, 12, 20])
    end

    it 'return an enumerator if there is no block' do
      expect([20, 3, 6, 10].my_map).to be_an(Enumerator)
    end
  end

  describe '#my_inject' do
    it 'the result of the sum of numbers inside the array is 39' do
      expect([20, 3, 6, 10].my_inject { |x, y| x + y }).to eql(39)
    end

    it 'the result of the sum of numbers inside the array is 39' do
      expect([20, 3, 6, 10].my_inject(:+)).to eql(39)
    end

    it 'the result of the multiplication by 3 of the numbers inside the array is 120' do
      expect([1, 2, 4, 5].my_inject(3, :*)).to eql(120)
    end

    it 'the result of the addition of the numbers inside the array and the parameter 3 is 15' do
      expect([1, 2, 4, 5].my_inject(3) { |x, y| x + y }).to eql(15)
    end
  end
end
