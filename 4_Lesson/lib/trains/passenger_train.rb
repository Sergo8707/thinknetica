class PassengerTrain < Train
  def add_carriage(carriage)
    if carriage.instance_of?(PassengerCarriage)
      super(carriage)
    else
      puts "К этому поезду нельзя прицепить этот вагон"
    end
  end
end