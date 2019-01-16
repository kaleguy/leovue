import VueChartJs from 'vue-chartjs'
import _ from 'lodash'
import Moment from 'moment'
import {extendMoment} from 'moment-range'

const moment = extendMoment(Moment)

const defaultColors = ['#8e5ea2', '#3cba9f', '#3e95cd', '#e8c3b9', '#c45850']

function dataSetFromGroups (groups, data, textItems, props) {
  const datasets = []
  let labels = []
  groups.forEach(group => {
    const dataSet = dataSetFromGroup(group, data, textItems, props)
    labels.push(dataSet.labels)
    const d = dataSet.datasets[0]
    d.labels = dataSet.labels
    d.label = dataSet.groupName
    datasets.push(d)
  })
  // get master label list
  labels = _.uniq(_.flatten(labels))
  datasets.forEach((dataSet, index) => {
    const dataObj = {}
    // get a hash of labels/data for this dataset
    for (let i = 0; i < dataSet.labels.length; i++) {
      const k = dataSet.labels[i]
      dataObj[k] = dataSet.data[i]
    }
    const points = []
    dataSet.backgroundColor = defaultColors[index]
    dataSet.borderColor = defaultColors[index]
    // normalize the data (add zeros for labels not in this dataset)
    labels.forEach(label => {
      points.push(dataObj[label] || 0)
    })
    dataSet.data = points
  })
  return { labels, datasets }
}

function dataSetFromGroup (group, data, textItems, props) {
  let dataKey = props.dataKey
  const item = JSON.search(data, '//*[group="' + group + '"]')[0]
  const children = item.children
  let items = []
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
  // if the data points are in a subobject, get list of those
  if (props.dataKey.indexOf('.') > -1) {
    dataKey = props.dataKey.substring(0, props.dataKey.lastIndexOf('.'))
    dataKey = '//' + dataKey.replace(/\./, '/')
    items = JSON.search(items, dataKey)
    dataKey = props.dataKey.substring(props.dataKey.lastIndexOf('.') + 1)
  }
  console.log(items.length)
  // debugger
  if (props.filterKey) {
    _.remove(items, item => _.get(item, props.filterKey) === props.filterValue)
  }
  // process the list items
  items.forEach(item => {
    const key = props.dataKey || 'pubdate'
    if (props.period) {
      dataKey = 'period'
      item.period = moment(item[key])[props.period]()
    }
  })
  items.forEach(item => {
    let k = item[dataKey]
    if (!k) {
      k = 'N/A'
    }
    dataObject[k] = dataObject[k] || 0
    dataObject[k] = dataObject[k] + 1
  })
  let labels = Object.keys(dataObject) // .sort()
  // fill in sparse data. Currently only works for years
  if (props.sparse) {
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
    labels = Object.keys(dataObject)
  }
  if (props.sort === 'key') {
    labels.sort()
  }
  if (props.sort === 'value') {
    labels.sort(function (a, b) {
      return dataObject[b] - dataObject[a]
    })
  }
  data = []
  labels.forEach(label => {
    data.push(dataObject[label])
  })
  // data = _.values(dataObject)
  // const backgroundColor = ['#0074D9', '#FF4136', '#2ECC40', '#FF851B', '#7FDBFF', '#B10DC9', '#FFDC00', '#001f3f', '#39CCCC', '#01FF70', '#85144b', '#F012BE', '#3D9970', '#111111', '#AAAAAA']
  const dataSet = {
    labels,
    groupName: item.vtitle,
    datasets: [
      {
        label: props.legendLabel,
        borderColor: props.borderColor || props.backgroundColor,
        backgroundColor: props.backgroundColor,
        data
      }
    ]
  }
  return dataSet
}

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
  if (_.isUndefined(colName)) {
    c = 0
  }
  if (_.isUndefined(c)) {
    c = -1
    for (let i = 0; i < firstRow.length; i++) {
      if (firstRow[i] === colName) {
        c = i
      }
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
  return {datasets, labels, title, colors}
}

function charts (Vue) {
  function getChartOptions (type) {
    const chartOptions = {
      extends: VueChartJs[type],
      props: {
        dataSet: String,
        dataTable: String,
        group: String,
        groups: Array,
        title: String,
        col: String,
        gridLines: Boolean,
        board: Boolean,
        dataKey: String,
        sparse: Boolean,
        period: String,
        filterKey: String,
        filterValue: String,
        sort: String,
        h: Number,
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
          // const b = window.document.getElementById('panes-separator')
          // let h = (b && b.scrollHeight) || 0
          if (this.h) {
            return this.h
          }
          let h = window.innerHeight
          if (h) {
            h = h - 60
          }
          return h || 400
        },
        xdataSetFromGroup () {
          // const props = this.$options.propsData
          console.log(dataSetFromGroup)
          let group = this.group
          let dataKey = this.dataKey
          let data = this.$store.state.leodata
          const textItems = this.$store.state.leotext
          const item = JSON.search(data, '//*[group="' + group + '"]')[0]
          const children = item.children
          let items = []
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
          // if the data points are in a subobject, get list of those
          if (this.dataKey.indexOf('.') > -1) {
            dataKey = this.dataKey.substring(0, this.dataKey.lastIndexOf('.'))
            dataKey = '//' + dataKey.replace(/\./, '/')
            items = JSON.search(items, dataKey)
            dataKey = this.dataKey.substring(this.dataKey.lastIndexOf('.') + 1)
          }
          console.log(items.length)
          if (this.filterKey) {
            _.remove(items, item => _.get(item, this.filterKey) === this.filterValue)
          }
          // process the list items
          items.forEach(item => {
            const key = this.dataKey || 'pubdate'
            if (this.period) {
              dataKey = 'period'
              item.period = moment(item[key])[this.period]()
            }
          })
          items.forEach(item => {
            let k = item[dataKey]
            if (!k) {
              k = 'N/A'
            }
            dataObject[k] = dataObject[k] || 0
            dataObject[k] = dataObject[k] + 1
          })
          let labels = Object.keys(dataObject) // .sort()
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
            labels = Object.keys(dataObject)
          }
          if (this.sort === 'key') {
            labels.sort()
          }
          if (this.sort === 'value') {
            labels.sort(function (a, b) {
              return dataObject[b] - dataObject[a]
            })
          }
          data = []
          labels.forEach(label => {
            data.push(dataObject[label])
          })
          // data = _.values(dataObject)
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
          layout: {
            padding: {
              left: 20,
              right: 20,
              top: 20,
              bottom: 20
            }
          },
          scales: {
            xAxes: [{
              gridLines: {display: this.gridLines},
              categoryPercentage: 0.9,
              barPercentage: 0.8,
              ticks: {
                beginAtZero: true,
                padding: 25
              }
            }],
            yAxes: [{
              gridLines: {display: this.gridLines},
              ticks: {
                beginAtZero: true,
                padding: 25
              }
            }]
          }
        }
        // kludge...
        if (type === 'Pie') {
          delete options.scales
        }
        if (type === 'Doughnut') {
          delete options.scales
        }
        if (type === 'Polar') {
          delete options.scales
        }
        let data = null

        if (this.group) {
          data = dataSetFromGroup(
            this.group,
            this.$store.state.leodata,
            this.$store.state.leotext,
            this.$options.propsData
          )
        }
        if (this.groups) {
          data = dataSetFromGroups(
            this.groups,
            this.$store.state.leodata,
            this.$store.state.leotext,
            this.$options.propsData
          )
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
  Vue.component('horizontalBar-chart', getChartOptions('HorizontalBar'))
  Vue.component('pie-chart', getChartOptions('Pie'))
  Vue.component('doughnut-chart', getChartOptions('Doughnut'))
  Vue.component('polar-chart', getChartOptions('PolarArea'))
}

export {charts}
