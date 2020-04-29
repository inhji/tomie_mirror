import Chartkick from '../chart'

export default {
  mounted() {
    const json = JSON.parse(this.el.dataset.chart)
    new Chartkick.ColumnChart("listen-index-chart", json, {
      dataset: {label: "Listens"}
    })
  }
}
