require_relative '../company_name'
require_relative '../validator'

class Carriage

  include CompanyName
  include Validator

  attr_reader :type

  def initialize(type)
    @type = type
    validate!
  end

  def carriage_type
      puts "Этот вагон #{type}"
  end

  def validate!
    raise 'Тип должен быть Грузовой или Пассажирский' unless %i[passenger cargo].include?(type)
  end
end