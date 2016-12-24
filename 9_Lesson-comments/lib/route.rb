require_relative 'trains/modules/validation'

class Route
  include Validation

  attr_reader :all_way

  validate :start_station, :presence
  validate :end_station, :presence

  def initialize(start_station, end_station)
    @all_way = [start_station, end_station]
    validate!
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
