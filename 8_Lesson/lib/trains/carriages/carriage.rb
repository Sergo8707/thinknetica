require_relative '../company_name'
require_relative '../validator'

class Carriage
  include CompanyName
  include Validator

  attr_reader :place

  def initialize(place)
    @place = place
  end

  def carriage_type
    puts 'Это вагон'
  end
end
