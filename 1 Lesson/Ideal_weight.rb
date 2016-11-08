puts 'Как Вас зовут?'

name = gets.chomp

puts "Какой у Вас рост в см.?"

begin
  height = Integer(gets.chomp)
rescue ArgumentError
  puts "Вы ввели не верное значение."
  retry
end

puts "Дорогой #{name}"
# Я немного не согласен с формулой. Не может человек при росте 111см. весить 1 кг.
puts height > 110 ? "Ваш идеальный вес #{height - 110} кг." : "Ваш вес уже оптимальный."
