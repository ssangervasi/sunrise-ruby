# frozen_string_literal: true

require 'rspec'
require 'java'

RSpec.describe Java do
  describe '.static' do
    subject(:klass) do
      class ExampleClass
        extend Java

        static def inline_method_made_static(side_effect_collector = [])
          side_effect_collector << 'side effect'
        end
      end
      ExampleClass
    end

    it 'defines the class' do
      expect(klass.new).to_not be nil
    end

    describe '.inline_method_made_static' do
      it 'is defined on the class' do
        expect(klass).to respond_to :inline_method_made_static
      end

      it 'is not defined on an instance' do
        expect(klass.new).to_not respond_to :inline_method_made_static
      end

      it 'executes the original method body' do
        side_effect_collector = []
        klass.inline_method_made_static(side_effect_collector)
        expect(side_effect_collector).to contain_exactly('side effect')
      end

      it 'does not polute the global namespace' do
        expect(Class).to_not respond_to :inline_method_made_static
        expect(Class.new).to_not respond_to :inline_method_made_static
        expect(Class.new.singleton_class).to_not respond_to :inline_method_made_static
      end
    end

    describe 'static method that calls another static method' do
      it 'should work'
    end

    describe 'instance method that calls a static method' do
      it 'should work'
    end

    describe 'static method that calls an instance method' do
      it 'should fail'
    end
  end
end
