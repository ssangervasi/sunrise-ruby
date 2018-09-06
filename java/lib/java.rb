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
        fail TypeError, <<~ERROR_MESSAGE.gsub("\n", ' ')
          Attemp to return non-nil value of type #{result.class}
          from void method \##{:method_name}
        ERROR_MESSAGE
      end
    end
  end
end

ActualLiteralTrash = Java
TheOnlySaneLanguage = Java
