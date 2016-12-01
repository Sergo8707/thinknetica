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
  menu = <<~MENU
                      --- ДОБРО ПОЖАЛОВАТЬ ---
                Вас приведствует компания  РЕЙСЫ-ШПАЛЫ
    _______________________________________________________________

    *> Если вы хотите создать маршрут, пожалуйста, нажмите 'r'
    *> Если вы хотите создать поезд, пожалуйста, нажмите 't'
    *> Если вы хотите создать станцию, пожалуйста, нажмите 's'
    *> Если хотите выйти, пожалуйста, нажмите 'x'
  MENU

  puts menu
  input = gets.chomp

  case input
    when 'r'
      route_menu
    when 't'
      train_menu
    when 's'
      station_menu
    when 'x'
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

  puts "Ваш маршрут: #{@routes.last.all_way.join(' -> ')}"

  add_st
end

def add_st
  menu_add_st = <<~MENU_ADD_ST


    *> Если вы хотите добавить промежуточные станции, нажмите 'c'
    *> Если вы хотите удалить станцию, нажмите 'd'
    *> Если вы хотите посмотреть маршрут, нажмите 'r'
    *> Если хотите выйти, нажмите 'x'

  MENU_ADD_ST

  puts menu_add_st

  input = gets.chomp
  case input
    when 'c'
      puts 'Введите промежуточную станцию'
      station = gets.chomp.to_s
      @stations << Station.new(station)
      @routes.last.add_station(station)
      puts "Ваш маршрут: #{@routes.last.all_way.join(' -> ')}"
    when 'd'
      puts 'Введите название станции которую хотите удалить'
      station_d = gets.chomp.to_s
      @routes.last.del_station(station_d)
      puts "Ваш маршрут: #{@routes.last.all_way.join(' -> ')}"
    when 'r'
      puts "Ваш маршрут: #{@routes.last.all_way.join(' -> ')}"
    when 'x'
      main_menu
    else
      add_st
  end
  add_st
end

def train_menu

  menu_train =<<~MENU_TRAIN

                      --- Меню TRAIN ---
    _______________________________________________________________

    Введите номер поезда
  MENU_TRAIN

  puts menu_train

  number = gets.chomp.to_i

  puts 'Введите название поезда'

  name_train = gets.chomp.to_s
  puts 'Поезд будет 1-пассажирский или 2-грузовой ? (Введите 1 или 2)'

  train_type = gets.chomp.to_s
  case train_type
    when '1'
      @trains << CargoTrain.new(number, name_train, :cargo)
    when '2'
      @trains << PassengerTrain.new(number, name_train, :passenger)
    else
      puts 'Ошибка ввода'
  end

  puts 'Вы создали поезд'
  puts @trains.last.show_train_info

  remote_train
end

def remote_train

  menu_remote_train =<<~MENU_REMOTE_TRAIN

    ----------------------------------------------
             Пульт управления поездом
    ----------------------------------------------

    *> Изменить скорость поезда'sp'
    *> Остановить поезд 'st'
    *> Прицепить вагон 'ac'
    *> Отцепить вагон 'dc'
    *> Задать маршрут 'r'
    *> Статус поезда 's'
    *> Если хотите выйти, пожалуйста, нажмите 'x'

  MENU_REMOTE_TRAIN

  if @trains.size > 0
    puts 'Выберите поезд (цифрой)'
    index = 0
    @trains.collect { |x| puts "#{index += 1})  #{x.name} - #{x.type}" }
    choice = gets.chomp.to_i
    @train_choice = @trains[choice - 1]

    puts menu_remote_train

    input = gets.chomp

    case input
      when 'sp'
        puts 'Укажите скорость поезда'
        sp = gets.chomp.to_i
        puts "Установлена скорость: #{ @train_choice.speed = sp} км./час."
      when 'st'
        puts "Cкорость поезда = #{ @train_choice.stop}км./час."
      when 'ac'
        @train_choice.add_carriage(CargoCarriage.new) if @train_choice.type == :cargo
        @train_choice.add_carriage(PassengerCarriage.new) if @train_choice.type == :passenger
        puts "Вагон прицеплен. У поезда #{@train_choice.name} - #{@train_choice.carriages.size} вагонов"
      when 'dc'
        @train_choice.del_carriage
        puts "количество вагонов: #{ @train_choice.carriages.size}"
      when 'r'
        train_route
      when 's'
        puts "#{@train_choice.show_train_info}"
        puts "#{@train_choice.show_next_station}"
        puts "#{@train_choice.current_station}"
        puts "#{@train_choice.show_prev_station}"
      when 'x'
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
    @routes.collect { |x| puts "#{index += 1}) #{x.all_way.join(' -> ')} " }
    choice = gets.chomp.to_i
    @train_choice.route = @routes[choice - 1]
    puts "#{@train_choice.current_station}"
    remote_train
  else
    puts 'Нет созданых маршрутов'
    main_menu
  end
end

def station_menu
  menu_station =<<~MENU_STATION


                      --- Меню STATION ---
    _______________________________________________________________

      *> Если вы хотите создать станцию, пожалуйста, нажмите 'c'
      *> Если вы хотите удалить станцию, нажмите 'd'
      *> Если вы хотите посмотреть все станции 'o'
      *> Управление станцией 'm'
      *> Если хотите выйти, пожалуйста, нажмите 'x'
  MENU_STATION

  puts menu_station
  input = gets.chomp
  case input
    when 'c'
      puts 'Введите название станции'
      station = gets.chomp.to_s
      if @stations.include?(station)
        puts 'такая станция уже есть'
      else
        @stations << Station.new(station)
      end

      puts "Вы создали станцию - #{@stations.last.name}"
    when 'd'
      puts 'Введите название станции которую хотите удалить'
      station_d = gets.chomp.to_s
      @routes.last.del_station(station_d)
      puts "Ваш маршрут: #{@routes.last.all_way.join(' -> ')}"
    when 'o'
      index = 0
      @stations.collect { |x| puts "#{index += 1}) #{x.name}" }
    when 'm'
      remote_station
    when 'x'
      main_menu
    else
      station_menu
  end

  station_menu
end

def remote_station

  menu_remote_station = <<~MENU_REMOTE_STATION

     ----------------------------------------------
               Пульт управления станцией
     ----------------------------------------------

    *> Если вы хотите поместить поезд на станцию, пожалуйста, нажмите 'a'
    *> Посмотреть список поездов на станции, нажмите 'l'
    *> Посмотреть список поездов на станции по типу, нажмите 'o'
    *> Отправить поезд со станции 'd'
    *> Если хотите выйти, пожалуйста, нажмите 'x'

  MENU_REMOTE_STATION

  if @stations.size > 0
    puts 'Выберите станцию (цифрой)'
    index = 0
    @stations.collect { |x| puts "#{index += 1}) #{x.name}" }
    choice = gets.chomp.to_i
    @station_choice = @stations[choice - 1]


    puts menu_remote_station

    input = gets.chomp
    case input
      when 'a'
        @station_choice.train_in(@train_choice)
      when 'l'
        @station_choice.train_list
      when 'o'
        puts 'По какому типу смотрим (грузовый или пассажирские)'
        train_type = gets.chomp.to_s
        @station_choice.trains_type(train_type)
      when 'd'
        puts 'Напишите имя поезда который хотите отправить'
        train_del = gets.chomp.to_s
        puts "Со станции #{@station_choice.name} уехал поезд - #{@train_choice.name}."
        @station_choice.train_go(train_del)
      when 'x'
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



