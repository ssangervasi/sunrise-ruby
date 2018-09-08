# frozen_string_literal: true

require 'rspec'
require 'java'

RSpec.describe Java do
  it { is_expected.to_not be_nil }

  it('is trash') { is_expected.to eq ActualLiteralTrash }
  it('is sane') { is_expected.to eq TheOnlySaneLanguage }
end
