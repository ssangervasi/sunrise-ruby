##
# Type & Schema definition
require 'dry-types'
require 'dry-struct'
require 'dry-validation'
require 'dry-logic'

module Types
  include Dry::Types.module
end

class Horse < Dry::Struct
  attribute :name, Types::Strict::String
  attribute :size, Types::Strict::String.enum('small', 'medium', 'large')
end

SmallHorse = Types.Constructor(Horse) do |name|
  ends_in_y = Types::Strict::String.constrained(format: /y$/)
  constrained_name = ends_in_y[name]
  Horse.new(name: constrained_name, size: 'small')
end

SmallHorseForm = Dry::Validation.Params do
  configure { config.type_specs = true }

  # Option 1: Does not raise error when constructor fails
  # required(:horse, SmallHorse)

  # Option 2: Resulting error message: "must be Horse"
  required(:horse, SmallHorse).filled(type?: Horse)
end

##
# Tests I want to pass
require 'rspec'

RSpec.describe SmallHorse do
  context 'when the horse param ends in "y"' do
    it 'creates a small horse' do
      horse = SmallHorse['Dippy']

      expect(horse).to be_a_kind_of(Horse)
      expect(horse.name).to eq 'Dippy'
      expect(horse.size).to eq 'small'
    end
  end

  context 'when the horse param ends in "o"' do
    it 'raises a constraint error' do
      expect { SmallHorse['Lungo'] }
        .to raise_error(Dry::Types::ConstraintError)
    end
  end

  context 'when the horse param is a number' do
    it 'raises a constraint error' do
      expect { SmallHorse[99] }
        .to raise_error(Dry::Types::ConstraintError)
    end
  end
end

RSpec.describe 'SmallHorseForm' do
  context 'when the horse param ends in "y"' do
    it 'succeeds' do
      result = SmallHorseForm.call(horse: 'Dippy')

      expect(result).to be_success
      expect(result[:horse]).to be_a_kind_of(Horse)
      expect(result[:horse].name).to eq 'Dippy'
    end
  end

  context 'when the horse param ends in "o"' do
    it 'fails' do
      result = SmallHorseForm.call(horse: 'Lungo')

      expect(result).to be_failure
      expect(result.messages).to include(:horse)
      expect(result.messages[:horse].first).to match /name must end in "y"/
    end
  end

  context 'when the horse param is a number' do
    it 'fails' do
      result = SmallHorseForm.call(horse: 99)

      expect(result).to be_failure
      expect(result.messages).to include(:horse)
      expect(result.messages[:horse].first).to match /name must end in "y"/
    end
  end
end
