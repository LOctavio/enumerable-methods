module Enumerable
  def my_each
    return to_enum unless block_given?

    i = 0
    while i < length
      yield self[i]
      i += 1
    end
  end

  def my_each_with_index
    return self unless block_given?

    i = 0
    while i < length
      yield self[i], i
      i += 1
    end
  end

  def my_select
    return to_enum unless block_given?

    arr = []
    my_each { |x| arr << x if yield x }
    arr
  end

  def my_all?(pattern = nil)
    val = true
    if pattern.nil?
      block_given? ? my_each { |x| val = false unless yield x } : val = my_all? { |x| !x.nil? && (x != false) }
    else
      my_each { |x| val = false unless pattern === x }
    end
    val
  end

  def my_any?(pattern = nil)
    val = false
    if pattern.nil?
      block_given? ? my_each { |x| val = true if yield x } : val = my_any? { |x| !x.nil? && (x != false) }
    else
      my_each { |x| val = true if pattern === x }
    end
    val
  end

  def my_none?(pattern = nil)
    val = true
    if pattern.nil?
      block_given? ? my_each { |x| val = false if yield x } : val = my_any? { |x| x == true }
    else
      my_each { |x| val = false if pattern === x }
    end
    val
  end

  def my_count(item = nil)
    count = 0
    if item.nil?
      block_given? ? my_each { |x| count += 1 if yield x } : my_each { count += 1 }
    else
      my_each { |x| count += 1 if item == x }
    end
    count
  end

  def my_map
    return to_enum unless block_given?

    arr = []
    my_each { |x| arr << yield(x) }
    arr
  end
end

puts 'my_each method:'
[1, 2, 3, 4].my_each { |x| puts x }
puts [1, 2, 3, 4].my_each
puts

puts 'my_each_with_index method:'
hash = {}
%w[first second third fourth].my_each_with_index { |item, index| hash[item] = index }
puts hash
hash2 = {}
%w[first second third fourth].my_each_with_index
puts hash2
puts

puts 'my_select_method:'
puts([1, 2, 3, 4, 5, 6, 7, 8, 9].my_select { |x| (x % 3).zero? })
puts [1, 2, 3, 4, 5, 6, 7, 8, 9].my_select
puts

puts 'my_all? method:'
puts([8, 4, 3, 9, 5].my_all? { |x| x >= 3 })
puts([8, 4, 3, 9, 5].my_all? { |x| x >= 4 })
puts [8, 4, 3, false, 9].my_all?
puts [8, 4, 3, 9, true].my_all?(Numeric)
puts %w[cas ljilj].my_all?(/d/)
puts

puts 'my_any? method:'
puts([8, 4, 3, 9, 5].my_any? { |x| x >= 3 })
puts([8, 4, 3, 9, 5].my_any? { |x| x >= 10 })
puts [8, 4, 3, false, 9].my_any?
puts [8, 4, 3, 9, true].my_any?(Numeric)
puts %w[cas ljilj].my_any?(/d/)
puts

puts 'my_none? method:'
puts([8, 4, 3, 9, 5].my_none? { |x| x >= 3 })
puts([8, 4, 3, 9, 5].my_none? { |x| x >= 10 })
puts

puts 'my_count method:'
puts([8, 4, 3, 9, 5].my_count { |x| (x % 3).zero? })
puts([8, 4, 3, 9, 5].my_count { |x| (x % 5).zero? })
puts [3, 4, 3, 9, 5].my_count(3)
puts [8, 4, 3, 9, 5].my_count
puts

puts 'my_map method:'
puts([1, 2, 3, 4, 5].my_map { |x| x * 2 })
puts [1, 2, 3, 4, 5].my_map
