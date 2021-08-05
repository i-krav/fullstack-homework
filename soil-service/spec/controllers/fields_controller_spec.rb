# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FieldsController do
  describe 'GET index' do
    before do
      get :index
    end

    it 'is successful' do
      expect(response.status).to eq(200)
    end

    it 'returns valid json' do
      expect(response.body).to include_json([{ humus_balance: nil }])
    end
  end

  describe 'GET humus_balance' do
    before do
      get :humus_balance, params: { crop_ids: [1, 2, 3] }
    end

    it 'is successful' do
      expect(response.status).to eq(200)
    end

    it 'returns valid json' do
      expect(response.body).to include_json({ humus_balance: -1 })
    end
  end
end
