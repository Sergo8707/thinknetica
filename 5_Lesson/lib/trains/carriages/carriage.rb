require_relative '../company_name'

class Carriage

  include CompanyName

  attr_reader :type

  def initialize(type)
    @type = type
  end

  def carriage_type
      puts "Этот вагон #{type}"
  end
end