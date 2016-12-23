require_relative '../modules/company_name'

class Carriage
  include CompanyName

  attr_reader :place, :type

  def initialize(place, type)
    @place = place
    @type = type
  end

  def carriage_type
    puts 'Это вагон'
  end
end
