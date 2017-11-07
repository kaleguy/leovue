import VueChartJs from 'vue-chartjs'

function charts (Vue) {
  Vue.component('line-chart', {
    extends: VueChartJs.Line,
    props: {
      dataSet: String
    },
    mounted () {
      this.renderChart(this.$store.state.dataSets[this.dataSet], {responsive: true, maintainAspectRatio: false})
    }
  })
  Vue.component('bar-chart', {
    extends: VueChartJs.Bar,
    props: {
      dataSet: String
    },
    mounted () {
      this.renderChart(this.$store.state.dataSets[this.dataSet], {responsive: true, maintainAspectRatio: false})
    }
  })

}


export {charts}

