class PassengerCarriage < Carriage
  def initialize(seats_total)
    @seats_total = seats_total.to_i
    @seats_count = 0
    super
  end

  def take_seat
    @seats_count += 1 if @seats_count < @seats_total
  end

  def show_busy_places
    puts "занятых мест: #{@seats_count}"
  end

  def free_seats
    puts "свободных мест: #{@seats_total - @seats_count}"
  end
end
