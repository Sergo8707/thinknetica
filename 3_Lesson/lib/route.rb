class Route

  def initialize (start_station, end_station)
    @all_way = [start_station, end_station]
  end

  def start_station
    @all_way.first
  end

  def end_station
    @all_way.last
  end

  def add_station(station)
    @all_way.insert(1, station)
  end

  def del_station(station)
    if station == end_station || station == start_station
      'Нельзя удалить начальную и конечную станцию'
    else
      @all_way.delete(station)
    end
  end

  def entire_route
    puts "Ваш маршрут : #{@all_way}"
  end

  def next_station(station)
    if station == end_station
      puts "Конечная. Дальше станций нет"
    else
      @all_way[@all_way.find_index(station).next]
    end
  end

  def prev_station(station)
    now_station = @all_way.find_index(station)
    if now_station > 0
      @all_way[now_station - 1]
    else
      puts "Вы на начальной станции #{@all_way.first}"
    end
  end
end