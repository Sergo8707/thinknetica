class Station

  attr_reader :name, :trains

  @@all_stations = []

  def self.all
    @@all_stations
  end

  def initialize (name)
    @name = name
    @trains = []
    @@all_stations << self
  end

  def train_in (train)
    @trains << train
  end

  def train_list
    @trains.each { |train| train.show_train_info }
  end

  def trains_type(type)
    @trains.each { |train| train.show_train_info if train.type == type }
  end

  def train_go(train)
    if @trains.empty?
      'На станции нет поездов'
    else
      @trains.delete(train)
    end
  end
end