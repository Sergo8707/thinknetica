sum = 0
buy = []

loop do
  puts 'введите стоп чтобы закончить покупки'
  puts
  print 'Введите название товара: '
  name = gets.chomp
  break if name == 'стоп'

  print 'Введите цену за ед.: '
  price = gets.chomp.to_f

  print 'Введите количество купленного товара: '
  amount = gets.chomp.to_f

  cart = ["Товар - #{name}", "Цена - #{price} $", "Количество - #{amount} шт.", "Сума - #{amount * price} $"]

  buy << cart

  sum += amount * price

end

buy.each do |buy|
  puts
  puts 'Вы купили: '
  puts
  puts buy
end

puts
puts "Сумма покупки составляет: #{sum} $"