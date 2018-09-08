# frozen_string_literal: true

module Java
  def void(method_name)
    method_name.tap do
      original_method = instance_method(method_name)
      define_method(method_name) do |*args, &block|
        original_method.bind(self).call(*args, &block)
        nil
      end
    end
  end

  def void_strict(method_name)
    method_name.tap do
      original_method = instance_method(method_name)
      define_method(method_name) do |*args, &block|
        result = original_method.bind(self).call(*args, &block)
        return if result.nil?
        raise TypeError, <<~ERROR_MESSAGE.tr("\n", ' ')
          Attemp to return non-nil value of type #{result.class}
          from void method \##{method_name}
        ERROR_MESSAGE
      end
    end
  end

  # Pure evil: intercepting private is necessary to support static.
  def private(*args)
    return super if args.length > 1
    return super if args.length.zero?
    method_name = args.first
    return super if method_defined?(method_name)
    # Try hitting the class method in case .static was used.
    self.class.send(:private, method_name)
  end

  def static(method_name)
    method_name.tap do
      original_method = instance_method(method_name)
      super_evil_hack_subclass = Class.new(self)
      singleton_class.define_method(method_name) do |*args, &block|
        original_method.bind(super_evil_hack_subclass.new).call(*args, &block)
      end
      remove_method(method_name)
    end
  end
end

ActualLiteralTrash = Java
TheOnlySaneLanguage = Java
