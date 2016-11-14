require './train.rb'

class Station

  def initialize (station_name)
    @station_name = station_name
    @trains = []
  end

  def train_in(train)
    @trains << train
  end

  def train_list
    @trains
  end

  def trains_type(type)
    @trains.each { |train| train.show_train_info if train.type == type }
  end

  def train_go(train)
    if @trains.empty?
      'На станции нет поездов'
    else
      puts "Со станции #{@station_name} уехал поезд - #{@trains.delete(train)}."
    end
  end

end