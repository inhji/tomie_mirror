import Chartkick from '../chart'

export default {
  mounted() {
    const json = JSON.parse(this.el.dataset.chart)
    new Chartkick.AreaChart("artists-last-two-weeks", json, {
      points: false,
      stacked: false,
      legend: "bottom"
    })
  }
}
