module Enumerable
  def my_each
    return to_enum unless block_given?

    i = 0
    while i < size
      yield to_a[i]
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

  def my_inject(val1 = nil, val2 = nil)
    first_element = true
    case val1
    when nil then val = to_a[0]
    when Numeric, Symbol
      val = val1
      first_element = false
    end
    if block_given?
      my_each { |x| first_element == true ? first_element = false : val = yield(val, x) }
    else
      val1, val2 = val2, val1 if val1.is_a? Symbol
      val = my_inject(val1) do |total, x|
        instance_eval "#{total} #{val2} #{x}", __FILE__, __LINE__
      end
    end
    val
  end
end

puts 'my_each method:'
(1..4).my_each { |x| puts x }
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
puts

puts 'my_inject method:'
puts([1, 2, 3, 4, 5].my_inject { |sum, n| sum * n })
puts((5..10).my_inject(3) { |sum, n| sum + n })
puts((5..10).my_inject(3, :*))
puts((5..10).my_inject(:*))
puts

def multiply_els(arr)
  val = arr.inject { |product, n| product * n }
  val
end

puts 'multiply_els method:'
puts multiply_els([2, 4, 5])
puts

puts 'my_map method with proc or block:'
new_proc = proc { |x| x * 2 }
puts([1, 2, 3, 4, 5].my_map(&new_proc))
puts
puts([1, 2, 3, 4, 5].my_map { |x| x * 3 })
puts
