# frozen_string_literal: true

# With regular activerecord model I would use proper serializer. Tha's kind a hack.
class FieldSerializer
  def self.fields_with_humus_balance
    new.fields_with_humus_balance
  end

  def fields_with_humus_balance
    all_fields.map do |field|
      field.merge(humus_balance: get_humus_balance_for_field(field), humus_balance_old: nil)
    end
  end

  private

  def all_fields
    @all_fields ||= FieldsService.instance.fetch_fields
  end

  def get_humus_balance_for_field(field)
    Fields::CalculatorService.new(crop_ids(field)).humus_balance
  end

  def crop_ids(field)
    field[:crops].collect{ |crop| crop[:crop][:value] }
  end
end