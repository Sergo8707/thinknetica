class PassengerCarriage < Carriage
  def initialize(seats_total)
    super('Пассажирский')
    @seats_total = seats_total.to_i
    @seats_count = 0
  end

  def take_seat
    @seats_count += 1 if @seats_count < @seats_total
  end

  def show_busy_places
    puts "занятых мест: #{@seats_count}"
  end

  def free_seats
    @seats_total - @seats_count
  end

  def show_free_seats
    puts "свободных мест: #{free_seats}"
  end
end
