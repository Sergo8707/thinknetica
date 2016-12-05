require_relative 'company_name'
require_relative 'instance_counter'

class Train

  include CompanyName
  include InstanceCounter

  attr_accessor :speed
  attr_reader :name, :type, :carriages, :number

  NUMBER_FORMAT = /^([a-z]|\d){3}-?([a-z]{2}|\d{2})$/i

  NAME_FORMAT = /\A[a-zа-яA-ZА-Я0-9_]+\z/

  @@trains = {}

  def self.find(number)
    @@trains[number]
  end

  def initialize(number, name, type)
    @number = number
    @name = name
    @type = type
    @speed = 0
    @carriages = []
    validate!
    @@trains[number] = self
    self.register_instance
  end

  def stop
    @speed = 0
  end

  def carriage_naw
    @carriages
  end

  def add_carriage(carriage)
    if @speed.zero?
      if carriage.type == self.type
        @carriages << carriage
      else
        puts 'Нельзя присоединить данный вагон к этому типу поезда'
      end
    else
      'Нужно остановиться чтобы прицепить вагон'
    end
    carriage_count
  end

  def del_carriage
    if @speed == 0
      @carriages.size > 0 ? @carriages.pop : 'Вагонов больне нет'
    else
      'Нужно остановиться чтобы отцепить вагон'
    end
    carriage_count
  end

  def route=(route)
    @route = route
    @current_station = @route.all_way[0]
    puts "Поезд принял маршрут, текущая станция #{@current_station}"
  end

  def current_station
    if @route
      puts "Текущая станция: #{@current_station}"
    else
      puts 'маршрут не задан'
    end
  end

  def next_station
    index_station = @route.all_way.index(@current_station)
    @current_station.train_go(self)
    index_station += 1
    @current_station = @route.all_way[index_station]
    @current_station.train_in(self)
  end

  def to_station(station)
    if @route.all_way.include?(station)
      @current_station = next_station
      puts "Поезд переместился на станцию #{@current_station}"
    else
      puts 'Такой станции нет!'
    end
  end

  def show_next_station
    index_station = @route.all_way.index(@current_station)
    next_station = @route.all_way[index_station + 1]
    puts "Следущая станция: #{next_station}"
  end

  def show_prev_station
    index_station = @route.all_way.index(@current_station)
    previous_station = @route.all_way[index_station - 1]
    puts "Предыдущая станция: #{previous_station}" if index_station > 0
  end

  def show_train_info
    puts "номер - #{@number}; имя - #{@name}; тип - #{@type}; количество вагонов: #{@carriages.size}"
  end

  def valid?
    validate!
  rescue
    false
  end

  protected


  def validate!
    raise 'Имя поезда не должно быть пустим' if name.empty?
    raise 'Номер поезда не может быть пустим' if number.nil?
    raise 'Номер должнен быть длинее 5 символов' if number.to_s.length < 3
    raise 'Имя должно быть длинее 6 символов' if name.to_s.length < 6
    raise 'Номер не должнен быть длинее 6 символов' if number.to_s.length > 7
    raise 'Имя не должно быть длинее 12 символов' if name.to_s.length > 12
    raise 'Номер поезда не отвечает формату, нужный формат(XXX-XX)' if number !~ NUMBER_FORMAT
    raise 'Имя не отвечает формату' if name !~ NAME_FORMAT
    raise 'Тип поезда не может быть nil!' if type.nil?
    raise 'Тип поезда должен быть Грузовой или Пассажирский' if type != :cargo && type != :passenger
    true
  end


  # доступ только из подкласов
  attr_writer :carriages

  def carriage_count
    puts "carriages: #{@carriages.size}"
  end

end