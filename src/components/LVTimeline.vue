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
      }
    },
    data: () => ({
      messageWhenNoItems: 'There are no items.',
      dataTimeline: [
        {
          from: new Date(2017, 5),
          title: 'Name',
          description:
            'Lorem ipsum dolor sit amet consectetur adipisicing elit. Eius earum architecto dolor, vitae magnam voluptate accusantium assumenda numquam error mollitia, officia facere consequuntur reprehenderit cum voluptates, ea tempore beatae unde.'
        },
        {
          from: new Date(2017, 8),
          title: 'Name',
          description:
            'Lorem ipsum dolor sit amet consectetur adipisicing elit. Eius earum architecto dolor, vitae magnam voluptate accusantium assumenda numquam error mollitia, officia facere consequuntur reprehenderit cum voluptates, ea tempore beatae unde.'
        },
        {
          from: new Date(2016, 11),
          title: 'Name',
          description:
            'Lorem ipsum dolor sit amet consectetur adipisicing elit. Eius earum architecto dolor, vitae magnam voluptate accusantium assumenda numquam error mollitia, officia facere consequuntur reprehenderit cum voluptates, ea tempore beatae unde.'
        },
        {
          from: new Date(2018, 7),
          title: 'Name',
          description:
            'Lorem ipsum dolor sit amet consectetur adipisicing elit. Eius earum architecto dolor, vitae magnam voluptate accusantium assumenda numquam error mollitia, officia facere consequuntur reprehenderit cum voluptates, ea tempore beatae unde.'
        },
        {
          from: new Date(2016, 1),
          title: 'Name',
          description:
            'Lorem ipsum dolor sit amet consectetur adipisicing elit. Eius earum architecto dolor, vitae magnam voluptate accusantium assumenda numquam error mollitia, officia facere consequuntur reprehenderit cum voluptates, ea tempore beatae unde.'
        },
        {
          from: new Date(2016, 6),
          title: 'Name',
          description:
            'Lorem ipsum dolor sit amet consectetur adipisicing elit. Eius earum architecto dolor, vitae magnam voluptate accusantium assumenda numquam error mollitia, officia facere consequuntur reprehenderit cum voluptates, ea tempore beatae unde.'
        },
        {
          from: new Date(2013, 1),
          title: 'Name',
          description:
            'Lorem ipsum dolor sit amet consectetur adipisicing elit. Eius earum architecto dolor, vitae magnam voluptate accusantium assumenda numquam error mollitia, officia facere consequuntur reprehenderit cum voluptates, ea tempore beatae unde.'
        },
        {
          from: new Date(2015, 1),
          title: 'Name',
          description:
            'Lorem ipsum dolor sit amet consectetur adipisicing elit. Eius earum architecto dolor, vitae magnam voluptate accusantium assumenda numquam error mollitia, officia facere consequuntur reprehenderit cum voluptates, ea tempore beatae unde.'
        },
        {
          from: new Date(2012, 1),
          title: 'Name',
          description:
            'Lorem ipsum dolor sit amet consectetur adipisicing elit. Eius earum architecto dolor, vitae magnam voluptate accusantium assumenda numquam error mollitia, officia facere consequuntur reprehenderit cum voluptates, ea tempore beatae unde.'
        }
      ]
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
          o.from = new Date(_.get(textData, 'pubdate', ''))
          o.title = _.get(textData, 'title', '')
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
