require_relative 'trains/modules/accessors'

class Test
  include Accessors

  attr_accessor_with_history :a, :b, :c
end

t = Test.new
t.a = 1
t.a = 3
t.a = 5

puts t.a_history.inspect
puts t.b_history.inspect
puts t.c_history.inspect