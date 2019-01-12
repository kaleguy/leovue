import VueChartJs from 'vue-chartjs'
import _ from 'lodash'
import Moment from 'moment'
import { extendMoment } from 'moment-range'
const moment = extendMoment(Moment)

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
        group: String,
        title: String,
        col: String,
        gridLines: Boolean,
        board: Boolean,
        dataKey: String,
        sparse: Boolean,
        period: String,
        legendLabel: String,
        backgroundColor: String,
        borderColor: String,
        responsive: {
          type: Boolean,
          default: true
        }
      },
      computed: {
        // if board display, make graph 90% of bpane
        height () {
          if (!this.board) {
            return 400
          }
          const b = window.document.getElementById('panes-separator')
          let h = (b && b.scrollHeight) || 0
          if (h) {
            h = h - 100
          }
          return h || 400
        },
        dataSetFromGroup () {
          let group = this.group
          let data = this.$store.state.leodata
          const textItems = this.$store.state.leotext
          const item = JSON.search(data, '//*[group="' + group + '"]')[0]
          const children = item.children
          const items = []
          children.forEach(child => {
            const t = textItems[child.t]
            let textData = {}
            try {
              textData = JSON.parse(t)
            } catch (e) {
            }
            items.push(textData)
          })
          let dataObject = {}
          items.forEach(item => {
            const key = this.dataKey || 'pubdate'
            if (this.period) {
              item.period = moment(item[key])[this.period]()
            }
          })
          items.forEach(item => {
            dataObject[item.period] = dataObject[item.period] || 0
            dataObject[item.period] = dataObject[item.period] + 1
          })
          const labels = Object.keys(dataObject).sort()
          // fill in sparse data. Currently only works for years
          if (this.sparse) {
            const sparseDataObject = {}
            const startDate = labels[0]
            const endDate = _.last(labels)
            const range = moment.range(startDate, endDate)
            let dates = Array.from(range.by('year'))
            dates.shift()
            dates = dates.map(m => m.format('YYYY'))
            dates.forEach(date => {
              sparseDataObject[date] = dataObject[date] || 0
            })
            dataObject = sparseDataObject
          }
          data = _.values(dataObject)
          // const backgroundColor = ['#0074D9', '#FF4136', '#2ECC40', '#FF851B', '#7FDBFF', '#B10DC9', '#FFDC00', '#001f3f', '#39CCCC', '#01FF70', '#85144b', '#F012BE', '#3D9970', '#111111', '#AAAAAA']
          const dataSet = {
            labels,
            datasets: [
              {
                label: this.legendLabel,
                borderColor: this.borderColor || this.backgroundColor,
                backgroundColor: this.backgroundColor,
                data
              }
            ]
          }
          return dataSet
        }
      },
      mounted () {
        const options = {
          responsive: this.responsive,
          maintainAspectRatio: false,
          scales: {
            xAxes: [ {
              gridLines: { display: this.gridLines },
              categoryPercentage: 0.9,
              barPercentage: 0.8
            }],
            yAxes: [ {
              gridLines: { display: this.gridLines },
              ticks: {
                beginAtZero: true,
                padding: 25
              }
            }]
          }
        }
        // kludge...
        if (type === 'Pie') { delete options.scales }
        if (type === 'Doughnut') { delete options.scales }
        if (type === 'Polar') { delete options.scales }
        let data = null
        if (this.group) {
          data = this.dataSetFromGroup
        }
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
