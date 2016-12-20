require_relative '../modules/company_name'

class Carriage
  include CompanyName

  attr_reader :place

  def initialize(place)
    @place = place
  end

  def carriage_type
    puts 'Это вагон'
  end
end
