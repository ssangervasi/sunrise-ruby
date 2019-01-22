# frozen_string_literal: true

module InlineString
  refine String do
    def inline
      self.gsub(/\n+/, ' ').strip
    end
  end
end
