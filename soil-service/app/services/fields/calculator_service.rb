# frozen_string_literal: true

module Fields
  class CalculatorService
    CONS_COEF = 1.3
    attr_reader :crop_ids

    def initialize(crop_ids)
      @crop_ids = crop_ids
    end

    def humus_balance
      crop_ids.each_with_index.sum do |id, index|
        consecutive?(index) ? CONS_COEF * humus_delta_by_id(id) : humus_delta_by_id(id)
      end.round(2)
    end

    private

    def humus_delta_by_id(id)
       crop_by_id(id)[:humus_delta]
    end

    def crop_by_id(id)
      all_crops.find { |crop| crop[:value] == id.to_i }
    end

    def consecutive?(index)
      return false if index == 0

      crop_ids[index] == crop_ids[index - 1]
    end

    def all_crops
      @all_crops ||= CropsService.instance.fetch_all_crops
    end
  end
end
