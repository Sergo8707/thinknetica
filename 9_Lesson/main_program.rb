require_relative 'lib/trains/carriages/carriage'
require_relative 'lib/trains/carriages/cargo_carriage'
require_relative 'lib/trains/carriages/passenger_carriage'
require_relative 'lib/trains/train'
require_relative 'lib/trains/cargo_train'
require_relative 'lib/trains/passenger_train'
require_relative 'lib/route'
require_relative 'lib/station'

class Menu

  def initialize
    @trains = []
    @routes = []
    @stations = []
  end

  def main_menu
    menu = <<~MENU
                        --- ДОБРО ПОЖАЛОВАТЬ ---
                  Вас приведствует компания  РЕЙСЫ-ШПАЛЫ
      _______________________________________________________________

      *> Если вы хотите создать маршрут, пожалуйста, нажмите - r
      *> Если вы хотите создать поезд, пожалуйста, нажмите - t
      *> Если вы хотите создать станцию, пожалуйста, нажмите - s
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

  private

  def route_menu
    begin
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
    rescue => e
      puts e.to_s
      retry
    end
    puts "Ваш маршрут: #{@routes.last.all_way.join(' -> ')}"
    add_st
  end

  def add_st
    menu_add_st = <<~MENU_ADD_ST


      *> Если вы хотите добавить промежуточные станции, нажмите - c
      *> Если вы хотите удалить станцию, нажмите - d
      *> Если вы хотите посмотреть маршрут, нажмите - r
      *> Если хотите выйти, нажмите - x

    MENU_ADD_ST

    puts menu_add_st

    input = gets.chomp
    case input
      when 'c'
        begin
          puts 'Введите промежуточную станцию'
          station = gets.chomp.to_s
          @stations << Station.new(station)
          @routes.last.add_station(station)
        rescue => e
          puts e.to_s
          retry
        end
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


    MENU_TRAIN
    puts menu_train
    puts 'Введите номер поезда'

    number = gets.chomp.to_s

    puts 'Поезд будет 1-грузовой или 2-пассажирский ? (Введите 1 или 2)'

    type = gets.chomp.to_s

    case type
      when '1'
        @trains << CargoTrain.new(number)
      when '2'
        @trains << PassengerTrain.new(number)
      else
        puts 'Ошибка! Вы не выбрали типа поезда.'
    end
    puts 'Вы создали поезд'
    puts @trains.last.show_train_info
    remote_train
  rescue => e
    puts e.to_s
    retry
  end

  def remote_train

    menu_remote_train =<<~MENU_REMOTE_TRAIN

      ----------------------------------------------
               Пульт управления поездом
      ----------------------------------------------

      *> Изменить скорость поезда - sp
      *> Остановить поезд - st
      *> Прицепить вагон - ac
      *> Отцепить вагон - dc
      *> Заполнить вагон - fc
      *> Задать маршрут - r
      *> Статус поезда - s
      *> Если хотите выйти, пожалуйста, нажмите - x

    MENU_REMOTE_TRAIN

    if @trains.size > 0
      puts 'Выберите поезд (цифрой)'
      index = 0
      @trains.collect { |train| puts "#{index += 1})  #{train.number} - #{train.type}" }
      choice = gets.chomp.to_i
      @train = @trains[choice - 1]

      puts menu_remote_train

      input = gets.chomp

      case input
        when 'sp'
          puts 'Укажите скорость поезда'
          sp = gets.chomp.to_i
          puts "Установлена скорость: #{ @train.speed = sp} км./час."
        when 'st'
          puts "Cкорость поезда = #{ @train.stop}км./час."
        when 'ac'
          add_wagon
        when 'fc'
          fill_carriage
        when 'dc'
          @train.del_carriage
          puts "количество вагонов: #{ @train.carriages.size}"
        when 'r'
          train_route
        when 's'
          puts "#{@train.show_train_info}"
          unless @train.current_station.nil?
            puts "#{@train.show_prev_station} #{@train.current_station} #{@train.show_next_station}"
          end
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

  def add_wagon
    case
      when @train.type == :cargo
        @train.type == :cargo
        puts 'Укажите объем вагона:'
        volume = gets.to_i
        @train.add_carriage(CargoCarriage.new(volume))
        puts "Вагон прицеплен. У поезда #{@train.name} - #{@train.carriages.size} вагонов"
      when @train.type == :passenger
        puts 'Укажите общее количество мест в вагоне:'
        seats = gets.to_i
        @train.add_carriage(PassengerCarriage.new(seats))
        puts "Вагон прицеплен. У поезда #{@train.name} - #{@train.carriages.size} вагонов"
      else
        puts 'Невозможно прицепить вагон'
    end
    remote_train
  end

  def fill_carriage
    if @train.carriages.size == 0
      puts 'Сначала прицепите вагоны'
      return
    end

    puts 'Выберите вагон'
    index = 0
    if @train.type == :cargo
      @train.show_carriage { |carriage| puts "#{index += 1} - вагон - объем: #{carriage.place}" }
      cargo_choice = gets.chomp.to_i
      if cargo_choice <= @train.carriages.size
        puts 'Укажите объем, который хотите занять: '
        volume = gets.chomp.to_i
        @train.carriages[cargo_choice - 1].take_volume(volume)
        @train.carriages[cargo_choice - 1].free_volume
      else
        puts 'Нет такого вагона'
      end
    elsif @train.type == :passenger
      @train.show_carriage do |carriage|
        puts "#{index += 1} - вагон - мест: #{carriage.place}"
        puts "#{carriage.show_free_seats}"
        puts
      end
      pass_choice = gets.chomp.to_i
      if pass_choice <= @train.carriages.size
        @train.carriages[pass_choice - 1].take_seat
        @train.carriages[pass_choice - 1].free_seats
      else
        puts 'Нет такого вагона'
      end
    end
    remote_train
  end

  def train_route
    if @routes.size > 0
      puts 'Выберите маршрут (цифрой)'
      index = 0
      @routes.collect { |station| puts "#{index += 1}) #{station.all_way.join(' -> ')} " }
      choice = gets.chomp.to_i
      @train.route = @routes[choice - 1]
      puts "#{@train.current_station}"
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

        *> Если вы хотите создать станцию, пожалуйста, нажмите - c
        *> Если вы хотите удалить станцию, нажмите - d
        *> Если вы хотите посмотреть все станции - o
        *> Управление станцией - m
        *> Если хотите выйти, пожалуйста, нажмите - x
    MENU_STATION

    puts menu_station
    input = gets.chomp
    case input
      when 'c'
        begin
          puts 'Введите название станции'
          station = gets.chomp.to_s
          if @stations.include?(station)
            puts 'такая станция уже есть'
          else
            @stations << Station.new(station)
          end
        rescue => e
          puts e.to_s
          retry
        end
        puts "Вы создали станцию - #{@stations.last.name}"
      when 'd'
        puts 'Введите название станции которую хотите удалить'
        station_d = gets.chomp.to_s
        @routes.last.del_station(station_d)
        puts "Ваш маршрут: #{@routes.last.all_way.join(' -> ')}"
      when 'o'
        index = 0
        @stations.collect { |station| puts "#{index += 1}) #{station.name}" }
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

      *> Если вы хотите поместить поезд на станцию, пожалуйста, нажмите - a
      *> Посмотреть список поездов на станции, нажмите - l
      *> Посмотреть список поездов на станции по типу, нажмите - o
      *> Отправить поезд со станции - d
      *> Если хотите выйти, пожалуйста, нажмите 'x'

    MENU_REMOTE_STATION

    if @stations.size > 0
      puts 'Выберите станцию (цифрой)'
      index = 0
      @stations.collect { |station| puts "#{index += 1}) #{station.name}" }
      choice = gets.chomp.to_i
      @station_choice = @stations[choice - 1]


      puts menu_remote_station

      input = gets.chomp
      case input
        when 'a'
          @station_choice.train_in(@train)
        when 'l'
          @station_choice.train_list
        when 'o'
          puts 'По какому типу смотрим (грузовый или пассажирские)'
          train_type = gets.chomp.to_s
          @station_choice.trains_type(train_type)
        when 'd'
          puts 'Напишите имя поезда который хотите отправить'
          train_del = gets.chomp.to_s
          puts "Со станции #{@station_choice.name} уехал поезд - #{@train.name}."
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
end


