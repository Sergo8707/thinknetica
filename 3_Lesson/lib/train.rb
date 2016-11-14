class Train

  attr_reader :route, :number, :name, :type, :amount_carriage

  def initialize(name, type, amount_carriage)
    @number = Random.new(10)
    @name = name
    @type = type
    @amount_carriage = amount_carriage
    @speed = 0
  end

  def stop
    self.speed = 0
  end

  def speed_train(value)
    @speed = value
  end

  def carriage_naw
    @amount_carriage
  end

  def add_carriage
    if @speed == 0
      @amount_carriage += 1
    else
      'Нужно остановиться чтобы прицепить вагон'
    end
  end

  def del_carriage
    if @speed == 0
      @amount_carriage > 0 ? @amount_carriage -= 1 : 'Вагонов больне нет'
    else
      'Нужно остановиться чтобы отцепить вагон'
    end
  end

  def route=(route)
    @route = route
    @now_station = @route.start_station
  end

  def go_next_station
    if @route
      @now_station.train_go(self)
      next_station_train = @route.next_station(@now_station)
      if next_station_train
        @now_station = next_station_train
        @now_station.train_in(self)
      end
    end
  end

  def go_prev_station
    if @route
      @now_station.train_go(self)
      prev_station_train = @route.prev_station(@now_station)
      if prev_station_train
        @now_station = prev_station_train
        @now_station.train_in(self)
      end
    end
  end

  def now_station
    if @route
      puts @now_station.name
    else
      puts "маршрут не задан"
    end
  end

  def next_station_train
    next_station_train = @route.next_station(@now_station)
    if next_station_train
      puts next_station_train.name
    else
      puts "конечная"
    end
  end

  def prev_station_train
    prev_station_train = @route.prev_station(@now_station)
    if prev_station_train
      puts prev_station_train.name
    else
      puts "начальная"
    end
  end

  def show_train_info
    puts "номер - #{number}; имя - #{name}; тип - #{type}; количество вагонов: #{amount_carriage}"
  end
end