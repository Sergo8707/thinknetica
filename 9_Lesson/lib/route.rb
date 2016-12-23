require_relative 'trains/modules/validation'
require_relative 'station'
class Route

  include Validation

  attr_reader :all_way

  validate :all_way, :type, Station

  def initialize(start_station, end_station)
    validate!
    @all_way = [start_station, end_station]
  end

  def add_station(station)
    @all_way.insert(-2, station)
  end

  def del_station(station)
    @all_way.delete(station)
  end

  def show_stations
    @all_way.each { |station| puts station }
  end
end
