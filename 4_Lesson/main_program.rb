require './lib/trains/carriages/carriage'
require './lib/trains/carriages/cargo_carriage'
require './lib/trains/carriages/passanger_carriage'
require './lib/trains/train'
require './lib/trains/cargo_train'
require './lib/trains/passenger_train'
require './lib/route'
require './lib/station'


@trains = []
@routes = []
@stations = []

def main_menu
  puts ''
  puts '                  --- ДОБРО ПОЖАЛОВАТЬ ---'
  puts '            Вас приведствует компания  РЕЙСЫ-ШПАЛЫ'
  puts '_______________________________________________________________'
  puts ''
  puts "*> Если вы хотите создать маршрут, пожалуйста, нажмите 'r'"
  puts "*> Если вы хотите создать поезд, пожалуйста, нажмите 't'"
  puts "*> Если вы хотите создать станцию, пожалуйста, нажмите 's'"
  puts "*> Если хотите выйти, пожалуйста, нажмите 'x'"

  input = gets.chomp
  case
    when input == 'r'
      route_menu
    when input == 't'
      train_menu
    when input == 's'
      station_menu
    when input == 'x'
      exit
    else
      main_menu
  end
end

def route_menu
  puts '                  --- Меню ROUTE ---'
  puts '_______________________________________________________________'
  puts ''
  puts 'Введите начальную станцию'
  @route_start = gets.chomp.to_s
  @stations << Station.new(@route_start)
  puts 'Введите конечную станцию'
  @route_end = gets.chomp.to_s
  @stations << Station.new(@route_end)

  @routes << Route.new(@route_start, @route_end)

  puts "Ваш маршрут: #{@routes.last.all_way.join(" -> ")}"

  add_st
end

def add_st
  puts ''
  puts ''
  puts "*> Если вы хотите добавить промежуточные станции, нажмите 'c'"
  puts "*> Если вы хотите удалить станцию, нажмите 'd'"
  puts "*> Если вы хотите посмотреть маршрут, нажмите 'r'"
  puts "*> Если хотите выйти, нажмите 'x'"

  input = gets.chomp
  case
    when input == 'c'
      puts 'Введите промежуточную станцию'
      station = gets.chomp.to_s
      @stations << Station.new(station)
      @routes.last.add_station(station)
      puts "Ваш маршрут: #{@routes.last.all_way.join(" -> ")}"
    when input == 'd'
      puts 'Введите название станции которую хотите удалить'
      station_d = gets.chomp.to_s
      @routes.last.del_station(station_d)
      puts "Ваш маршрут: #{@routes.last.all_way.join(" -> ")}"
    when input == 'r'
      puts "Ваш маршрут: #{@routes.last.all_way.join(" -> ")}"
    when input == 'x'
      main_menu
    else
      add_st
  end
  add_st
end

def train_menu

  puts '                  --- Меню TRAIN ---'
  puts '_______________________________________________________________'
  puts ''
  puts 'Введите название поезда'
  name_train = gets.chomp.to_s
  puts "Поезд будет 'пассажирский' или 'грузовой'? "

  train_type = gets.chomp.to_s
  case train_type
    when 'грузовой'
      @trains << CargoTrain.new(name_train, train_type)
    when 'пассажирский'
      @trains << PassengerTrain.new(name_train, train_type)
    else
      puts 'Ошибка ввода'
  end

  puts 'Вы создали поезд'
  puts @trains.last.show_train_info

  remote_train
end

def remote_train
  puts ''
  puts 'Пульт управления поездом'
  puts ''
  if @trains.size > 0
    puts 'Выберите поезд (цифрой)'
    index = 0
    @trains.collect { |x| puts "#{index += 1})  #{x.name} - #{x.type}" }
    choice = gets.chomp.to_i
    @train_choice = @trains[choice - 1]
    puts "*> Изменить скорость поезда'sp'"
    puts "*> Остановить поезд 'st'"
    puts "*> Прицепить вагон 'ac'"
    puts "*> Отцепить вагон 'dc'"
    puts "*> Задать маршрут 'r'"
    puts "*> Статус поезда's'"
    puts "*> Если хотите выйти, пожалуйста, нажмите 'x'"

    input = gets.chomp

    case
      when input == 'sp'
        puts 'Укажите скорость поезда'
        sp = gets.chomp.to_i
        puts "Установлена скорость: #{ @train_choice.speed = sp} км./час."
      when input == 'st'
        puts "Cкорость поезда = #{ @train_choice.stop}км./час."
      when input == 'ac'
        @train_choice.add_carriage(CargoCarriage.new) if @train_choice.type == 'грузовой'
        @train_choice.add_carriage(PassengerCarriage.new) if @train_choice.type == 'пассажирский'
        puts "Вагон прицеплен. У поезда #{@train_choice.name} - #{@train_choice.carriages.size} вагонов"
      when input == 'dc'
        @train_choice.del_carriage
        puts "количество вагонов: #{ @train_choice.carriages.size}"
      when input == 'r'
        train_route
      when input == 's'
        puts "#{@train_choice.show_train_info}"
        puts "#{@train_choice.show_next_station}"
        puts "#{@train_choice.show_current_station}"
        puts "#{@train_choice.show_prev_station}"
      when input == 'x'
        main_menu
      else
        remote_train
    end

  else
    puts 'Поезд не создан'
  end

  remote_train
end

def train_route
  if @routes.size > 0
    puts 'Выберите маршрут (цифрой)'
    index = 0
    @routes.collect { |x| puts "#{index += 1}) #{x.all_way.join(" -> ")} " }
    choice = gets.chomp.to_i
    @train_choice.route = @routes[choice - 1]
    puts "#{@train_choice.show_current_station}"
    remote_train
  else
    puts 'Нет созданых маршрутов'
    main_menu
  end
end

def station_menu
  puts '                  --- Меню STATION ---'
  puts '_______________________________________________________________'
  puts ''
  puts "*> Если вы хотите создать станцию, пожалуйста, нажмите 'c'"
  puts "*> Если вы хотите удалить станцию, нажмите 'd'"
  puts "*> Если вы хотите посмотреть все станции 'o'"
  puts "*> Управление станцией 'm'"
  puts "*> Если хотите выйти, пожалуйста, нажмите 'x'"

  input = gets.chomp
  case
    when input == 'c'
      puts 'Введите название станции'
      station = gets.chomp.to_s
      if @stations.include?(station)
        puts 'такая станция уже есть'
      else
        @stations << Station.new(station)
      end

      puts "Вы создали станцию - #{@stations.last.name}"
    when input == 'd'
      puts 'Введите название станции которую хотите удалить'
      station_d = gets.chomp.to_s
      @routes.last.del_station(station_d)
      puts "Ваш маршрут: #{@routes.last.all_way.join(" -> ")}"
    when input == 'o'
      index = 0
      @stations.collect { |x| puts "#{index += 1}) #{x.name}" }
    when input == 'm'
      remote_station
    when input == 'x'
      main_menu
    else
      station_menu
  end

  station_menu
end

def remote_station

  if @stations.size > 0
    puts 'Выберите станцию (цифрой)'
    index = 0
    @stations.collect { |x| puts "#{index += 1}) #{x.name}" }
    choice = gets.chomp.to_i
    @station_choice = @stations[choice - 1]

    puts "*> Если вы хотите поместить поезд на станцию, пожалуйста, нажмите 'a'"
    puts "*> Посмотреть список поездов на станции, нажмите 'l'"
    puts "*> Посмотреть список поездов на станции по типу, нажмите 'o'"
    puts "*> Отправить поезд со станции 'd'"
    puts "*> Если хотите выйти, пожалуйста, нажмите 'x'"

    input = gets.chomp
    case
      when input == 'a'
        # Тут я немного не понял. Помещать поезд можно любой и когда захочешь?
        # Или только когда у конкретного поезда который идет по маршруту настала эта станция?
        @station_choice.train_in(@train_choice)
      when input == 'l'
        @station_choice.train_list
      when input == 'o'
        puts 'По какому типу смотрим (грузовый или пассажирские)'
        train_type = gets.chomp.to_s
        @station_choice.trains_type(train_type)
      when input == 'd'
        puts 'Напишите имя поезда который хотите отправить'
        train_del = gets.chomp.to_s
        puts "Со станции #{@station_choice.name} уехал поезд - #{@train_choice.name}."
        @station_choice.train_go(train_del)
      when input == 'x'
        main_menu
      else
        remote_station
    end
  else
    puts 'Нет созданых станций'
  end
  remote_station
end

main_menu



