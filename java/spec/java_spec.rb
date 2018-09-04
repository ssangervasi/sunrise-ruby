require 'rspec'

require 'java'

RSpec.describe Java do
  it { is_expected.to_not be_nil }

  it('is trash') { is_expected.to eq ActualLiteralTrash }
  it('is sane') { is_expected.to eq TheOnlySaneLanguage }


  describe '.void' do
    subject(:class_with_void_method) do
      class ExampleClass
        extend Java

        void def basic_void_method
          nil
        end
      end
      ExampleClass
    end

    it 'works' do
      expect(class_with_void_method.new).to_not be nil
    end
  end
end
