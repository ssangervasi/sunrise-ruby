require 'rspec'
require 'java'

RSpec.describe Java do
  it { is_expected.to_not be_nil }

  it('is trash') { is_expected.to eq ActualLiteralTrash }
  it('is sane') { is_expected.to eq TheOnlySaneLanguage }

  describe '.void' do
    subject(:klass) do
      class ExampleClass
        extend Java

        attr_reader :side_effect

        void def honest_void_method(side_effect_value = nil)
          @side_effect = side_effect_value
          nil
        end

        void def deceitful_void_method(side_effect_value = nil)
          @side_effect = side_effect_value
          'non-nil value'
        end

        private void def private_deceitful_void_method(side_effect_value = nil)
          @side_effect = side_effect_value
          'non-nil value'
        end
      end
      ExampleClass
    end

    it 'defines the class' do
      expect(klass.new).to_not be nil
    end

    describe '#honest_void_method' do
      it 'returns nil' do
        expect(klass.new.honest_void_method).to be nil
      end

      it 'executes the original method body' do
        instance = klass.new
        instance.honest_void_method('side effect')
        expect(instance.side_effect).to eq 'side effect'
      end
    end

    describe '#deceitful_void_method' do
      it 'raises a TypeError' do
        expect { klass.new.deceitful_void_method }
          .to raise_error(TypeError)
      end

      it 'executes the original body' do
        instance = klass.new
        begin
          instance.deceitful_void_method('side effect')
        rescue TypeError; end
        expect(instance.side_effect).to eq 'side effect'
      end
    end

    describe '#private_deceitful_void_method' do
      context 'when called normally' do
        it 'raises a NoMethodError' do
          expect { klass.new.private_deceitful_void_method }
            .to raise_error(NoMethodError)
        end
      end

      context 'when called with #send' do
        it 'raises a TypeError' do
          expect { klass.new.send(:private_deceitful_void_method) }
            .to raise_error(TypeError)
        end

        it 'executes the original body' do
          instance = klass.new
          begin
            instance.send(:private_deceitful_void_method, 'side effect')
          rescue TypeError; end
          expect(instance.side_effect).to eq 'side effect'
        end
      end
    end
  end
end
