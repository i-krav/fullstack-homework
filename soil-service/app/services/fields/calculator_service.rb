# frozen_string_literal: true

module Fields
  class CalculatorService
    attr_reader :crop_ids

    def initialize(crop_ids)
      @crop_ids = crop_ids
    end

    def humus_balance
      nil
    end
  end
end
