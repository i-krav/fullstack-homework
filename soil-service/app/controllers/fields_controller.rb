# frozen_string_literal: true

class FieldsController < ApplicationController
  def index
    render json: FieldsService.instance.fetch_fields
  end

  def humus_balance
    render json: { humus_balance: Fields::CalculatorService.new(params[:crop_ids]).humus_balance }
  end
end
