fib = [0, 1]

until fib[-1] + fib[-2] > 100 do
  fib << fib[-1] + fib[-2]
end

puts fib