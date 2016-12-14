require_relative 'trains/validator'

class Route

  include Validator

  attr_reader :all_way

  def initialize (start_station, end_station)
    @all_way = [start_station, end_station]
    validate!
  end

  def add_station (station)
    @all_way.insert(-2, station)
  end

  def del_station (station)
    @all_way.delete(station)
  end

  def show_stations
    @all_way.each { |station| puts station }
  end

  protected

  def validate!
    raise 'Маршрут не может быть пустым' if all_way.empty?
    true
  end
end