require '../trains/carriages/carriage'

class Train

  attr_accessor :speed
  attr_reader :route, :name, :type, :carriages, :index_station

  def initialize(name, type)
    @number = rand(1..100)
    @name = name
    @type = type
    @speed = 0
    @carriages = []
  end

  def stop
    self.speed = 0
  end

  def speed_train(speed)
    self.speed = speed if speed > 0
  end

  def carriage_naw
    @carriages
  end

  def current_speed
    puts self.speed
  end

  def add_carriage(carriage)
    if @speed == 0
      @carriages << carriage
    else
      'Нужно остановиться чтобы прицепить вагон'
    end
    show_carriages_count
  end

  def del_carriage
    if @speed == 0
      @amount_carriage > 0 ? @amount_carriage -= 1 : 'Вагонов больне нет'
    else
      'Нужно остановиться чтобы отцепить вагон'
    end
    show_carriages_count
  end

  def route=(route)
    @route = route
    @index_station = 0
    @route.all_way[self.index_station].all_way(self)
  end

  def go_next_station
    if self.index_station == self.route.all_way.size-1
      self.index_station = 0
      self.route.all_way.reverse!
    end
    current_station = self.route.all_way[index_station]
    current_station.train_go(self)
    self.index_station += 1
    current_station = self.route.all_way[index_station]
    current_station.train_in (self)
  end

  def show_current_station
    if @route
      puts "Текущая станция: #{self.route.all_way[self.index_station].name}"
    else
      puts "маршрут не задан"
    end
  end

  def show_next_station
    if self.index_station == self.route.all_way.size-1
      puts "Конечная станция"
    else
      puts "Следущая станция: #{self.route.all_way[self.index_station + 1].name}"
    end
  end

  def show_prev_station
    if self.index_station == 0
      puts "Начальная станция"
    else
      puts "Следущая станция: #{self.route.all_way[self.index_station - 1].name}"
    end
  end

  def show_train_info
    puts "номер - #{number}; имя - #{name}; тип - #{type}; количество вагонов: #{amount_carriage}"
  end

  private

  # В private положил метод который можно использовать только в подкласах

  attr_writer :carriages, :index_station

  def show_carriages_count
    puts "Количество вагонов: #{self.carriages.size}"
  end
end