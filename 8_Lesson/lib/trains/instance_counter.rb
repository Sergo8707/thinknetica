module InstanceCounter

  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods

    def instances
      self.instance
    end

    protected

    attr_accessor :instance

    def add
      self.instance ||= 0
      self.instance += 1
    end
  end

  module InstanceMethods

    def register_instance
      self.class.send(:add)
    end
  end
end