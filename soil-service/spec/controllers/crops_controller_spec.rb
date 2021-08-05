# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CropsController do
  describe 'GET index' do
    it 'is successful' do
      get :index

      expect(response.status).to eq(200)
    end
  end

  describe 'GET humus_balance' do
    it 'is successful' do
      get :humus_balance

      expect(response.status).to eq(201)
    end
  end
end
