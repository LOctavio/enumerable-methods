module Enumerable
  def my_each
    return to_enum unless block_given?

    i = 0
    arr = []
    while i < size
      yield (arr[i] = to_a[i])
      i += 1
    end
    arr
  end

  def my_each_with_index
    return to_enum unless block_given?

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
      block_given? ? my_each { |x| val = false if yield x } : my_any? { |x| return false if x == true }
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

def multiply_els(arr)
  arr.inject { |product, n| product * n }
end
