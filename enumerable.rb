module Enumerable
  def my_each
    i = 0
    while i < length
      yield self[i]
      i += 1
    end
  end
end

puts "my_each method:"
[1, 2, 3, 4].my_each { |x| puts x }
