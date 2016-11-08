puts 'Как Вас зовут?'

name = gets.chomp

puts "Какой у Вас рост в см.?"

begin
  height = Integer(gets.chomp)
rescue ArgumentError
  puts "Вы ввели не верное значение."
  retry
end

ideal_weight = height - 110

puts "Дорогой #{name}"

puts height > 109 ? "Ваш идеальный вес #{ideal_weight} кг." : "Ваш вес уже оптимальный."
