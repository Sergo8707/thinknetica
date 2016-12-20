module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    def validate(attribute, type, option = nil)
      @check_array ||= []
      @check_array << { attribute: attribute, type: type, option: option }
    end
  end

  module InstanceMethods
    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    private

    def validate!
      our_class = self.class
      while our_class != Object
        if check_array = our_class.class_eval('@check_array')
          check_array.each do |value|
            var = instance_variable_get("@#{value[:attribute]}")
            method_checking = (value[:type]).to_s
            send method_checking, var, value[:option] if value[:option]
          end
        end
        our_class = our_class.superclass
      end
    end

    def presence(name)
      raise 'не может быть пустым' if name.nil? || name == ''
    end

    def format(name, format)
      raise 'неверный формат' unless name =~ format
    end

    def type(name, type)
      raise 'неверный тип' unless name.is_a?(type)
    end
  end
end
