# frozen_string_literal: true

require 'rspec'

require './inline_string'

RSpec.describe InlineString do
  let(:using_class) do
    class UsingInlineString
      using InlineString

      def instance_method_using_tilde_doc
        <<~TILDE_DOC.inline
          This is the first line.
          This is the second line.
        TILDE_DOC
      end
    end
    UsingInlineString
  end

  it 'works' do
    expect(using_class.new.instance_method_using_tilde_doc)
      .to eq 'This is the first line. This is the second line.'
  end
end
