class Station

  STATION_FORMAT = /^[а-яa-zA-ЯA-Z0-9]/i

  attr_reader :name, :trains

  @@all_stations = []

  def self.all
    @@all_stations
  end

  def initialize (name)
    @name = name
    @trains = []
    validate!
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

  def valid?
    validate!
  rescue
    false
  end

  private

  def validate!
    raise 'Название станции не может быть пустым!' if name.empty?
    raise 'Название станции должно быть длинее 3 символов' if name.to_s.length < 3
    raise 'Название станции не должно быть длинее 16 символов' if name.to_s.length > 16
    raise 'Название станции не отвечает формату' if name !~ STATION_FORMAT
    true
  end
end