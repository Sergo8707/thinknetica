class CargoCarriage < Carriage
  def initialize(total_volume)
    @total_volume = total_volume.to_i
    @volume_count = 0
    super
  end

  def take_volume(volume)
    @volume_count += volume if volume > @total_volume - @volume_count
  end

  def show_taken_volume
    puts "Занимаемый объем: #{@volume_count}"
  end

  def free_volume
    @total_volume - @volume_count
  end

  def show_free_volume
    puts "Свободный объем: #{free_volume}"
  end
end
