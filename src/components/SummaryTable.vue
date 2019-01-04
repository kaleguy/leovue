<template>
  <div class="summary-table">
    <table-component
      @rowClick="dataTableClick"
      :data="chapters"
      sort-by="pubdate"
      sort-order="desc"
    >
      <table-column v-for="col in colKeys"
                    :key="col.title"
                    v-bind="col"></table-column>
    </table-component>
  </div>
</template>

<script>
  import _ from 'lodash'
  import util from '../util'
  export default {
    name: 'summary-table',
    props: {
      cols: {
        type: Array,
        default: [
        ]
      }
    },
    data () {
      return {
      }
    },
    computed: {
      colKeys () {
        const cKeys = []
        this.cols.forEach(col => {
          const newCol = {}
          newCol.show = col.show.replace(/\./g, '~')
          newCol.label = col.label
          newCol['data-type'] = col.dataType
          cKeys.push(newCol)
        })
        return cKeys
      },
      chapters () {
        let data = this.$store.state.leodata
        const item = JSON.search(data, '//*[id="' + this.$store.state.currentItem.id + '"]')[0]
        const children = item.children
        const items = []
        const textItems = this.$store.state.leotext
        children.forEach(child => {
          const t = textItems[child.t]
          let textData = {}
          try {
            textData = JSON.parse(t)
          } catch (e) {
            console.log(e, child.id)
          }
          const o = {}
          _.forEach(this.cols, col => {
            o[col.show.replace(/\./g, '~')] = _.get(textData, col.show, '')
          })
          items.push(o)
        })
        return items
        // return this.$store.state.viewType
      }
    },
    methods: {
      dataTableClick: function (r) {
        this.$parent.$parent.dataTableClick(r)
      },
      gotoSection: function (title) {
        const plainTitle = _.trim(title)
        const searchTitle = '« ' + plainTitle + ' »'
        let leodata = this.$store.state.leodata
        if (window.parent !== window.self) {
          leodata = window.parent.lconfig.leodata
        }
        let titleObj = JSON.search(leodata, '//*[vtitle="' + searchTitle + '"]')[0]
        if (!titleObj) {
          let i = 0
          while (!titleObj && (i < leodata.length)) {
            titleObj = util.getObjectByKeyFromTree(leodata[i], 'vtitle', plainTitle)
            i = i + 1
          }
        }
        let id = null
        let index = null
        if (titleObj) {
          id = titleObj.id
          if (titleObj.index) {
            index = titleObj.index
          }
          this.$store.dispatch('setCurrentItem', {id})
          if (window.parent !== window.self) {
            console.log('posting message')
            window.parent.postMessage(JSON.stringify({
              namespace: 'leovue',
              eventName: 'setcurrentitem',
              state: {id, index}
            }), '*')
          }
        }
      }
    },
    components: {}
  }
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style lang="sass" scoped>
.summary-table
  cursor: pointer
</style>
