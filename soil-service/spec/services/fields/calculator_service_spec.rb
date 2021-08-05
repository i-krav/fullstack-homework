# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Fields::CalculatorService do
  describe '#humus_balance' do
    subject(:humus_balance) { described_class.new(crop_ids).humus_balance }

    context 'not consecutive' do
      let(:crop_ids) { [1, 2, 3] }

      it 'returns correct value' do
        is_expected.to eq(-1)
      end
    end

    context 'consecutive' do
      let(:crop_ids) { [1, 1, 2] }

      it 'returns correct value' do
        is_expected.to eq(-5.6)
      end
    end
  end
end
