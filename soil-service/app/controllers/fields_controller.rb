# frozen_string_literal: true

class FieldsController < ApplicationController
  def index
    render json: FieldSerializer.fields_with_humus_balance
  end

  def humus_balance
    render json: { humus_balance: Fields::CalculatorService.new(params[:crop_ids]).humus_balance }
  end
end
