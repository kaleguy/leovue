<template>
  <div class="lv-timeline">
    <timeline
      :timeline-items="chapters"
      :message-when-no-items="messageWhenNoItems"
      :unique-year="true"
      order="desc"
    />
  </div>
</template>

<script>
  import _ from 'lodash'
  import util from '../util'
  import Timeline from 'timeline-vuejs'
  export default {
    name: 'lv-timeline',
    components: {
      timeline: Timeline
    },
    props: {
      group: {
        type: String,
        default: ''
      },
      title: {
        type: String,
        default: ''
      },
      from: {
        type: String,
        default: ''
      },
      description: {
        type: String,
        default: ''
      }
    },
    data: () => ({
      messageWhenNoItems: 'There are no items.'
    }),
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
        const item = JSON.search(data, '//*[group="' + this.group + '"]')[0]
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
          let key = this.from || 'blank'
          o.from = new Date(_.get(textData, key, ''))
          key = this.title || 'blank'
          o.title = _.get(textData, key, '')
          key = this.description || 'blank'
          o.description = _.get(textData, key, '')
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
    }
  }
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style lang="sass" scoped>
.summary-table
  cursor: pointer
</style>
