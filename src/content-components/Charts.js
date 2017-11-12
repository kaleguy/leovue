import VueChartJs from 'vue-chartjs'
import _ from 'lodash'

function dataTableToDataSet (csvArray) {
  const datasets = []
  let labels = csvArray.splice(0, 1)[0]
  labels.splice(0, 1)
  labels.splice(-1, 1)
  labels = labels.map(_.trim)
  csvArray.forEach(d => {
    d = d.map(_.trim)
    let set = {}
    set.label = d.splice(0, 1)
    set.borderColor = d.splice(-1, 1)
    set.data = d.map(item => +item)
    set.fill = false
    datasets.push(set)
  })
  return {datasets, labels}
}

function charts (Vue) {
  Vue.component('line-chart', {
    extends: VueChartJs.Line,
    props: {
      dataSet: String,
      dataTable: String
    },
    mounted () {
      let data = null
      if (this.dataSet) {
        data = this.$store.state.dataSets[this.dataSet]
      }
      if (this.dataTable) {
        let d = this.$store.state.dataTables[this.dataTable]
        data = dataTableToDataSet(d)
      }
      this.renderChart(
          data,
          { responsive: true, maintainAspectRatio: false }
      )
    }
  })
  Vue.component('bar-chart', {
    extends: VueChartJs.Bar,
    props: {
      dataSet: String
    },
    mounted () {
      this.renderChart(
        this.$store.state.dataSets[this.dataSet],
        { responsive: true, maintainAspectRatio: false }
      )
    }
  })
}

export {charts}

