import VueChartJs from 'vue-chartjs'
import _ from 'lodash'

const defaultColors = ['#8e5ea2', '#3cba9f', '#3e95cd', '#e8c3b9', '#c45850']

/**
 * Remove columns from array and return in collection
 * @param table
 */
function extractOptionColumns (table) {
  const options = {}
  const colNames = table[0].map(_.trim)
  colNames.forEach((colName, c) => {
    if (colName.indexOf('$') === 0) {
      extractColumn(table, options, colName, c)
    }
  })
  return options
}
function extractColumn (table, options, colName, c) {
  const column = []
  const firstRow = table[0]
  if (_.isUndefined(colName)) { c = 0 }
  if (_.isUndefined(c)) {
    c = -1
    for (let i = 0; i < firstRow.length; i++) {
      if (firstRow[i] === colName) { c = i }
    }
    if (c === -1) {
      return {}
    }
  }
  firstRow.splice(c, 1)
  for (let r = 1; r < table.length; r++) {
    column.push(_.trim(table[r].splice(c, 1)))
  }
  options[colName] = column
}

function dataTableToDataSet (dataTable) {
  const csvArray = _.cloneDeep(dataTable.arr)
  const title = dataTable.title
  const options = extractOptionColumns(csvArray)
  let colors = options.$colors || defaultColors
  const datasets = []
  let labels = csvArray.splice(0, 1)[0]
  labels.splice(0, 1)
  labels = labels.map(_.trim)
  csvArray.forEach((d, i) => {
    d = d.map(_.trim)
    let set = {}
    set.label = d.splice(0, 1)[0]
    set.borderColor = colors[i]
    set.backgroundColor = set.borderColor
    set.pointBackgroundColor = set.borderColor
    set.pointBorderColor = set.borderColor
    set.data = d.map(item => +item)
    set.fill = false
    datasets.push(set)
  })
  return { datasets, labels, title, colors }
}

function charts (Vue) {
  function getChartOptions (type) {
    const chartOptions = {
      extends: VueChartJs[type],
      props: {
        dataSet: String,
        dataTable: String,
        title: String,
        col: String,
        gridLines: Boolean
      },
      mounted () {
        const options = {
          responsive: false,
          maintainAspectRatio: false,
          scales: {
            xAxes: [ {
              gridLines: { display: this.gridLines },
              categoryPercentage: 0.9,
              barPercentage: 0.8
            }],
            yAxes: [ {
              gridLines: { display: this.gridLines }
            }]
          }
        }
        // kludge...
        if (type === 'Pie') { delete options.scales }
        if (type === 'Doughnut') { delete options.scales }
        if (type === 'Polar') { delete options.scales }
        let data = null
        if (this.dataSet) {
          data = this.$store.state.dataSets[this.dataSet]
          if (!data) {
            data = window.parent.lconfig.dataSets[this.dataSet]
          }
        }
        if (this.dataTable) {
          let d = this.$store.state.dataTables[this.dataTable]
          if (!d) {
            d = window.parent.lconfig.dataTables[this.dataTable]
          }
          const dataArray = d.arr
          if (this.col) {
            let colIndex = dataArray[0].findIndex(c => c === this.col)
            let colData = dataArray.map(v => v[colIndex])
            let colNames = dataArray.map(v => v[0])
            colData.shift()
            colNames.shift()
            data = dataTableToDataSet(d)
            data.labels = colNames
            data.datasets = [{
              data: colData,
              backgroundColor: data.colors,
              borderColor: data.colors
            }]
            // kludge..
            if (type === 'Bar') {
              _.set(options, 'legend.display', false)
            }
          } else {
            data = dataTableToDataSet(d)
          }
        }
        options.title = {
          display: true,
          text: this.title || data.title || ''
        }
        this.renderChart(data, options)
      }
    }
    return chartOptions
  }
  Vue.component('line-chart', getChartOptions('Line'))
  Vue.component('bar-chart', getChartOptions('Bar'))
  Vue.component('pie-chart', getChartOptions('Pie'))
  Vue.component('doughnut-chart', getChartOptions('Doughnut'))
  Vue.component('polar-chart', getChartOptions('PolarArea'))
}

export {charts}
