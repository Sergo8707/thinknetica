require_relative '../company_name'

class Carriage

  include CompanyName

  attr_reader :type

  def initialize(type)
    @type = type
    validate!
  end

  def carriage_type
      puts "Этот вагон #{type}"
  end

  def valid?
    validate!
  rescue
    false
  end

  def validate!
    raise 'Тип должен быть Грузовой или Пассажирский' unless %i[passenger cargo].include?(type)
  end
end