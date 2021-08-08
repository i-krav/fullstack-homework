import { PureComponent } from 'react'
import { sortBy } from 'lodash'

import CropSelect from './CropSelect'
import { Crop, Field, SeasonalCrop } from './types'
import { fetchCrops, fetchFields, fetchHumusBalance } from './api'
import buildNewFieldsState from './buildNewFieldsState'

type Props = {}

type State = {
  allCrops: Array<Crop>,
  fields: Array<Field>
}

export default class Table extends PureComponent<Props, State> {
  constructor(props: Props) {
    super(props)

    this.state = {
      allCrops: [],
      fields: [],
    }
  }

  componentDidMount = async () =>
    this.setState({
      fields: await fetchFields(),
      allCrops: await fetchCrops(),
    })

  render = () =>
    <div className="table">
      <div className="table__row table__row--header">
        <div className="table__cell">Field name</div>
        <div className="table__cell table__cell--right">Field area (ha)</div>
        <div className="table__cell table__cell--center">2020 crop</div>
        <div className="table__cell table__cell--center">2021 crop</div>
        <div className="table__cell table__cell--center">2022 crop</div>
        <div className="table__cell table__cell--center">2023 crop</div>
        <div className="table__cell table__cell--center">2024 crop</div>
        <div className="table__cell table__cell--right">Humus balance</div>
      </div>

      {sortBy(this.state.fields, field => field.name).map(field => this.renderFieldRow(field))}
    </div>

  renderFieldRow = (field: Field) => {
    const statusClass = (() => {
      if (field.humus_balance_old === null || field.humus_balance_old === field.humus_balance) {
        return '';
      } else if (field.humus_balance > field.humus_balance_old) {
        return 'bg-green';
      } else {
        return 'bg-red';
      };
    })();

    return (
      <div className="table__row" key={field.id}>
        <div className="table__cell">{field.name}</div>
        <div className="table__cell table__cell--right">{field.area}</div>

        {sortBy(field.crops, crop => crop.year).map(seasonalCrop => this.renderCropCell(field, seasonalCrop))}

        <div className={`table__cell table__cell--right ${statusClass}`}>
          {field.humus_balance}
        </div>
      </div>
    );
  }

  renderCropCell = (field: Field, seasonalCrop: SeasonalCrop) =>
    <div className="table__cell table__cell--center table__cell--with-select" key={seasonalCrop.year}>
      <CropSelect
        selectedCrop={seasonalCrop.crop}
        allCrops={this.state.allCrops}
        onChange={newCrop => this.changeFieldCrop(newCrop, field.id, seasonalCrop.year, field.humus_balance)}
      />
    </div>

  changeFieldCrop = async (newCrop: Crop | null, fieldId: number, cropYear: number, humusBalanceOld: number ) => {
    const humusBalance = await this.getHumusBalance(fieldId, newCrop, cropYear);
    this.setState(
      buildNewFieldsState(this.state.fields, newCrop, fieldId, cropYear, humusBalance.humus_balance, humusBalanceOld),
    )
  }

  getHumusBalance = (fieldId: number, newCrop: Crop | null, cropYear: number ) => {
    const field = this.state.fields.find( ({ id }) => id  === fieldId );
    const crops = field!.crops;
    const cropIndex = crops.findIndex((crop => crop.year == cropYear));
    // Set newly selected crop
    crops[cropIndex].crop = newCrop;

    const cropIds = sortBy(crops, crop => crop.year)
      .map(seasonCrop => seasonCrop!.crop!.value )
      .filter(Number)

    const humusBalanceResponse = fetchHumusBalance(cropIds);
    return humusBalanceResponse;
  }
}
