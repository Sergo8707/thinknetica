class PassengerCarriage < Carriage
  def initialize (seats_total, type = :passenger)
    @seats_total = seats_total.to_i
    @seats_count = 0
    super
  end

  def take_seat
    @seats_count += 1 if @seats_total > @seats_count
  end

  def busy_place
    @seats_count
  end

  def free_seats
    @seats_total - @seats_count
  end
end
