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
    _do_evil(
      args,
      intercept: ->(method_name) { singleton_class.send(:private, method_name) },
      ignore: proc { super }
    )
  end

  # Pure evil: intercepting private is necessary to support static.
  def public(*args)
    _do_evil(
      args,
      intercept: ->(method_name) { singleton_class.send(:public, method_name) },
      ignore: proc { super }
    )
  end

  def _do_evil(args, intercept:, ignore:)
    method_name = args.first
    should_ignore = args.length > 1 || args.length.zero? || method_defined?(method_name)
    return ignore.call(method_name) if should_ignore
    intercept.call(method_name)
  end

  def static(method_name)
    method_name.tap do
      original_method = instance_method(method_name)
      super_evil_hack_subclass = Class.new(self) { def initialize; end }
      singleton_class.define_method(method_name) do |*args, &block|
        original_method.bind(super_evil_hack_subclass.new).call(*args, &block)
      end
      remove_method(method_name)
    end
  end
end

ActualLiteralTrash = Java
TheOnlySaneLanguage = Java
