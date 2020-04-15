module Enumerable
  def my_each
    i = 0
    while i < length
      yield self[i]
      i += 1
    end
  end

  def my_each_with_index
    i = 0
    while i < length
      yield self[i], i
      i += 1
    end
  end

  def my_select
    i = 0
    arr = []
    while i < length
      arr << self[i] if yield self[i]
      i += 1
    end
    arr
  end
end

puts 'my_each method:'
[1, 2, 3, 4].my_each { |x| puts x }
puts
puts 'my_each_with_index method:'
hash = {}
%w[first second third fourth].my_each_with_index { |item, index| hash[item] = index }
puts hash
puts
puts 'my_select_method:'
puts([1, 2, 3, 4, 5, 6, 7, 8, 9].my_select { |x| (x % 3).zero? })
