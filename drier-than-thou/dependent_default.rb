require 'dry-types'
require 'dry-struct'
require 'rspec'
require 'pry'

module Types
  include Dry::Types.module
end


class Horse < Dry::Struct
  def self.with_default_value(source_value:)
    new(
      source_value: source_value,
      dependent_value: "#{source_value} horses"
    )
  end

  WithDefultValue = Types.Constructor(self, &method(:with_default_value))

  attribute :source_value, Types::Strict::Integer
  attribute :dependent_value, Types::Strict::String
end

RSpec.describe Horse do
  subject(:horse) do
    described_class::WithDefultValue[
      source_value: 10
    ]
  end

  it 'is initialized with the defaulted value' do
    expect(horse.dependent_value).to eq '10 horses'
  end
end
