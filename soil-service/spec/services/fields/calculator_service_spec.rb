require 'rails_helper'

RSpec.describe CalculatorService do
  describe '#humus_balance' do
    let(:params) { nil }
    subject(:humus_balance) { described_class.new(params).humus_balance }

    it 'returns correct value' do
      expect(humus_balance).to include_json({ humus_balance: nil })
    end
  end
end
