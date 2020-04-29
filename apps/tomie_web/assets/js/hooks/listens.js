import Chartkick from '../chart'

export default {
  mounted() {
    const json = JSON.parse(this.el.dataset.chart)
    new Chartkick.ColumnChart("artists-last-two-weeks", json, {
      dataset: {label: "Listens"}
    })
  }
}
