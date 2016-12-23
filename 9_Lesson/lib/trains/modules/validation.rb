module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    attr_reader :check

    def validate(*arg)
      arg ||= []
      self.check ||= []
      self.check << arg
    end

    private

    attr_writer :check
  end

  module InstanceMethods
    def validate!
      self.class.check.each do |value|
        v = instance_variable_get("@#{value[0]}".to_sym)
        send value[1].to_sym, v, value[2]
      end
    end

    def valid?
      validate!
      true
    rescue
      false
    end

    private

    def presence(value, _options)
      raise 'Ошибка: Значение не может быть пустым!' if value.empty?
    end

    def format(value, options)
      raise 'Ошибка: Не верный формат вводимых значений!' if value !~ options
    end

    def type(value, options)
      raise 'Ошибка: Не верный тип данных!' if value.is_a?(options)
    end
  end
end