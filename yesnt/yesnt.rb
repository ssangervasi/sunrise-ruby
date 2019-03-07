
module Yesnt
  class Bool
  end

  class True < Bool; end
  class False < Bool; end

  ::TrueClass.extend(True)
  ::FalseClass.extend(False)
end


puts true.is_a?(Yesnt::Bool)
puts false.is_a?(Yesnt::Bool)
