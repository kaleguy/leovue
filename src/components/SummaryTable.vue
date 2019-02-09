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
  function getDataArray (data, type, id) {
    const item = JSON.search(data, '//*[' + type + '="' + id + '"]')[0]
    return item
      ? item.children
      : []
  }
  export default {
    name: 'summary-table',
    props: {
      group: {
        type: Number,
        default: null
      },
      mgroup: {
        type: Number,
        default: null
      },
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
        function getColumnData (cols, d) {
          const o = {}
          _.forEach(cols, col => {
            o[col.show.replace(/\./g, '~')] = _.get(d, col.show, '')
          })
          return o
        }
        let data = this.$store.state.leodata
        const id = this.group || this.mgroup || this.$store.state.currentItem.id
        const key = this.group
          ? 'group'
          : this.mgroup
            ? 'mgroup'
            : 'id'
        const d = getDataArray(data, key, id)
        const items = []
        const textItems = this.$store.state.leotext
        d.forEach(child => {
          let t = textItems[child.t]
          let textData = {
          }
          try {
            this.mgroup
              ? textData = child.metadata
              : textData = JSON.parse(t)
          } catch (e) {
            console.log(e, child.id)
          }
          textData.title = child.name
          textData.vtitle = child.vtitle
          items.push(getColumnData(this.cols, textData))
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
