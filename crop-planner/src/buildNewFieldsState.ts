import { Crop, Field } from './types'
import { filter, find } from 'lodash'

// Here we emulate a reducer
const buildNewFieldsState = (oldFields: Array<Field>, newCrop: Crop | null, fieldId: number, cropYear: number, humusBalance: number, humusBalanceOld: number | null) => {
  const oldField = find(oldFields, field => field.id === fieldId)!

  return {
    fields: [
      ...filter(oldFields, field => field.id !== fieldId),
      {
        ...oldField,
        crops: [
          ...filter(oldField.crops, crop => crop.year !== cropYear),
          { year: cropYear, crop: newCrop },
        ],
        humus_balance: humusBalance,
        humus_balance_old: humusBalanceOld,
      },
    ],
  }
}

export default buildNewFieldsState
