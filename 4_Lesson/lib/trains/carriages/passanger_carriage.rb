class PassengerCarriage < Carriage
  def initialize(type)
    super(type)
  end

  def show_info
    puts "данный вагон - #{type}"
  end
end
