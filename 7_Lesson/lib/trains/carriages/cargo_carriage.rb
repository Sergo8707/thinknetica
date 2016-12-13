class CargoCarriage < Carriage
  def initialize (total_volume, type = :cargo)
    @total_volume = total_volume.to_i
    @volume_count = 0
    super
  end

  def take_volume(volume)
    if @total_volume > @volume_count
      if volume > @total_volume - @volume_count
        puts 'Не влезает'
      else
        @volume_count += volume
      end
    end
  end

  def taken_volume
    puts "Занимаемый объем: #{@volume_count}"
  end

  def free_volume
    puts "Свободный объем: #{@total_volume - @volume_count}"
  end
end