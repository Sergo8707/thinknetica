puts 'Введите сегодняшнее число'
day_now = gets.to_i
puts 'Введите номер месяца'
month_now = gets.to_i
puts 'Введите год'
year_now = gets.to_i

months = {'01' => 31, '02' => 28, '03' => 31, '04' => 30, '05' => 31, '06' => 30,
          '07' => 31, '08' => 31, '09' => 30, '10' => 31, '11' => 30, '12' => 31}

year = (year_now % 4 == 0 && year_now % 100 != 0) || year_now % 400 == 0

months['02'] = 29 if year

day_number = day_now

months.each { |month, day| day_number += day if month.to_i < month_now }

puts "Порядковый номер даты, начиная с начала года #{day_number} день"