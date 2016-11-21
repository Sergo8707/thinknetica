class CargoTrain < Train
  def add_carriage(carriage)
    if carriage.instance_of?(CargoCarriage)
      super(carriage)
    else
      puts "К этому поезду нельзя прицепить этот вагон"
    end
  end
end