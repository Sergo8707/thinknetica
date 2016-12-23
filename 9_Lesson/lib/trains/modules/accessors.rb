module Accessors
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*arg)
      arg.each do |name|
        var_name = "@#{name}".to_sym
        define_method(name) { instance_variable_get(var_name) }

        define_method("#{name}=".to_sym) do |value|
          instance_variable_set(var_name, value)
          @history ||= {}
          @history[name] ||= []
          @history[name] << value
        end
        define_method("#{name}_history") { @history[name] }
      end
    end

    def strong_attr_accessor(name, class_name)
      var_name = "@#{name}".to_sym
      define_method(name) { instance_variable_get(var_name) }

      define_method("#{name}=".to_sym) do |value|
        raise 'Не верный присваемый тип' if value.is_a?(class_name)
        instance_variable_set(var_name, value)
      end
    end
  end
end