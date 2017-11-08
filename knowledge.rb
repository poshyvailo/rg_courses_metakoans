# frozen_string_literal: true

# Class
class Module

  def attribute(name, &block)
    name, value = name.first if name.is_a? Hash
    # setter
    define_method name + '=' do |value|
      instance_variable_set(:"@#{name}", value)
    end
    # getter
    define_method name do
      if instance_variable_defined? :"@#{name}"
        instance_variable_get(:"@#{name}")
      else
        instance_variable_set(:"@#{name}", block_given? ? instance_eval(&block) : value)
      end
    end
    # name?
    define_method name + '?' do
      instance_variable_get(:"@#{name}")
    end
  end

end