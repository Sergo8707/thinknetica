require '../lib/trains/train'

class Route

  attr_reader :start_station, :end_station, :all_way

  def initialize (start_station, end_station)
    @start_station = start_station
    @end_station = end_station
    @all_way = [start_station, end_station]
  end

  def add_station (station)
    self.all_way.insert(-2, station)
  end

  def del_station (station)
    if station.trains_count == 0
      self.all_way.delete(station)
    else
      puts "На станции есть поезда"
    end
  end

  def show_stations
    puts "Начальная станция - #{@start_station.name} "
    self.all_way.each { |station| puts "следущая станция - #{station.name}" }
    puts "Конечная станция - #{@end_station.name} "
  end

end