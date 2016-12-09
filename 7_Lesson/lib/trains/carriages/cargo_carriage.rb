class CargoCarriage < Carriage
  def initialize (total_volume, type = :cargo)
    @total_volume = total_volume.to_i
    @volume_count = 0
    super
  end

  def take_volume(volume)
    @volume_count += volume if @total_volume > @volume_count
  end

  def taken_volume
    @volume_count
  end

  def free_volume
    @total_volume - @volume_count
  end
end