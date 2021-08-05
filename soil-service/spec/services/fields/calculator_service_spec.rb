# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Fields::CalculatorService do
  let(:crop_ids) { [1, 1, 2] }

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

  describe '#consecutive?' do
    subject(:consecutive?) { described_class.new(crop_ids).send(:consecutive?, index) }

    context 'for index eq 0' do
      let(:index) { 0 }

      it 'returns false' do
        is_expected.to be_falsey
      end
    end

    context 'for index eq 1' do
      let(:index) { 1 }

      it 'returns true' do
        is_expected.to be_truthy
      end
    end

    context 'for index eq 2' do
      let(:index) { 2 }

      it 'returns false' do
        is_expected.to be_falsey
      end
    end
  end

  describe '#humus_delta_by_id' do
    subject(:humus_delta_by_id) { described_class.new(crop_ids).send(:humus_delta_by_id, id) }

    context 'for id eq 1' do
      let(:id) { 1 }

      it 'returns correct value' do
        is_expected.to eq -2
      end
    end
  end

  describe '#crop_by_id' do
    subject(:crop_by_id) { described_class.new(crop_ids).send(:crop_by_id, id) }

    context 'for id eq 2' do
      let(:id) { 2 }

      it 'returns correct crop' do
        is_expected.to eq({ humus_delta: -1, label: 'Winter Wheat', value: 2 })
      end
    end
  end
end
