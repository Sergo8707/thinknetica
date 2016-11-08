puts 'Введите основание треугольника'
a = gets.chomp.to_f
puts 'Введите высоту треугольника'
h = gets.chomp.to_f

s = 0.5 * a * h
s = s.to_i if s.zero?
puts "Площадь треугольника = #{s}"