class Train

  attr_accessor :speed
  attr_reader :name, :type, :carriages

  def initialize(name, type)
    @number = rand(1..100)
    @name = name
    @type = type
    @speed = 0
    @carriages = []
  end

  def stop
    @speed = 0
  end

  def carriage_naw
    @carriages
  end

  def add_carriage(carriage)
    if self.speed == 0 && carriage.type == self.type
      @carriages << carriage
    elsif !carriage.type == self.type
      puts 'Нельзя присоединить данный вагон к этому типу поезда'
    else
      'Нужно остановиться чтобы прицепить вагон'
    end
    carriage_count
  end

  def del_carriage
    if self.speed == 0
      @carriages.size > 0 ? @carriages.pop : 'Вагонов больне нет'
    else
      'Нужно остановиться чтобы отцепить вагон'
    end
    carriage_count
  end

  def route=(route)
    @route = route
    @show_current_station = @route.all_way[0]
    puts "Поезд принял маршрут, текущая станция #{@show_current_station}"
  end

  def show_current_station
    if @route
      puts "Текущая станция: #{@show_current_station}"
    else
      puts "маршрут не задан"
    end
  end

  def show_next_station
    index_station = @route.all_way.index(@show_current_station)
    next_station = @route.all_way[index_station + 1]
    puts "Следущая станция: #{next_station}"
  end

  def show_prev_station
    index_station = @route.all_way.index(@show_current_station)
    previous_station = @route.all_way[index_station - 1]
    puts "Предыдущая станция: #{previous_station}" if index_station > 0
  end

  def to_station(station)
    if @route.all_way.include?(station)
      index_station = @route.all_way.index(station)
      @show_current_station = @route.all_way[index_station]
      puts "Поезд переместился на станцию #{@show_current_station}"
    else
      puts "Такой станции нет!"
    end
  end

  def show_train_info
    puts "номер - #{@number}; имя - #{@name}; тип - #{@type}; количество вагонов: #{@carriages.size}"
  end

  protected

  # доступ только из подкласов
  attr_writer :carriages

  def carriage_count
    puts "carriages: #{@carriages.size}"
  end

end