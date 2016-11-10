puts 'Введите коэффициент a '
a = gets.to_f
puts 'Введите коэффициент b '
b = gets.to_f
puts 'Введите коэффициент c '
c = gets.to_f

d = b ** 2 - 4 * a * c

if d < 0
  puts "Дискриминант = #{d}"
  puts 'Так как дискриминант меньше нуля, то уравнение не имеет действительных корней'
elsif d == 0
  x = b * -1 / 2 * a
  puts "Дискриминант = #{d}. X = #{x}"
else
  x_one = b * -1 + Math.sqrt(d) / 2 * a
  x_two = b * -1 - Math.sqrt(d) / 2 * a
  puts "Дискриминант = #{d} X1 = #{x_one} X2 = #{x_two}"
end