class FieldsController < ApplicationController
  def index
    render json: FieldsService.instance.fetch_fields
  end

  def humus_balance
    render json: { humus_balance: nil }
  end
end
