# Я как гуманитарий не люблю математических задач :-) Конкретно в этой я не уверен.
# Совсем запутался с этими углами.

puts 'Введите сторону a треугольника'
a = gets.to_f
puts 'Введите сторону b треугольника'
b = gets.to_f
puts 'Введите сторону c треугольника'
c = gets.to_f

x = [a, b, c].sort

if (x[2].to_i ** 2) == (x[0].to_f ** 2 + x[1].to_f ** 2)
  puts 'треугольник равнобедренный и равносторонний, но не прямоугольный'
elsif a == b || a == c || b == c
  puts 'треугольник является равнобедренным (т.е. у него равны 2 стороны)'
else
  puts 'треугольник не является прямоугольным'
end