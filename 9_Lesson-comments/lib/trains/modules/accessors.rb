module Accessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}"
      # getter
      define_method(name) { instance_variable_get(var_name) }
      # setter
      define_method("#{name}=") do |value|
        instance_variable_set(var_name, value)
        @history_array ||= []
        @history_array[var_name] ||= []
        @history_array[var_name] << value
      end

      # history method
      define_method("#{name}_history") { @history_array[var_name] }
    end
  end

  def strong_attr_accessor(name, type)
    var_name = "@#{name}".to_sym
    # getter
    define_method(name) { instance_variable_get(var_name) }
    # setter
    define_method("#{name}=".to_sym) do |value|
      if value.class == type
        instance_variable_set(var_name, value)
      else
        raise 'неверный тип значения'
      end
    end
  end
end
