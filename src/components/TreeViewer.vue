
<template>
  <div class="treeviewer">
    <splitpane :leftPaneStyle="leftPaneStyle">
      <ul slot="left" class="left-pane" :style="ulStyle">
        <div v-for="(itemdata, index) in data">
        <item
          class="item"
          :model="itemdata"
          :top="getTop(index)"
          :textItems="text"
          :targetEl="target.el">
        </item>
        </div>
      </ul>
      <contentpane slot="right"></contentpane>
    </splitpane>
  </div>
</template>
<br/>

<script>
  import Item from './Item'
  import ContentPane from './ContentPane'
  import SplitPane from './SplitPane'

  let target = {el: true, v: null}
  export default {
    name: 'treeviewer',
    components: {
      item: Item,
      contentpane: ContentPane,
      splitpane: SplitPane
    },
    data: function () {
      return {
        target: target
      }
    },
    methods: {
      getTop (index) {
        if (!index) {
          return this.top
        }
      }
    },
    computed: {
      ulStyle () {
        const p = window.lconfig.leftPanePadding || '0'
        const c = window.lconfig.leftPaneBackground || '#fff'
        return `padding-left:${p}; background-color:${c}`
      },
      leftPaneStyle () {
        const w = window.lconfig.leftPaneWidth || '420px'
        const c = window.lconfig.leftPaneBackground || '#fff'
        return `width:${w};background-color:${c}`
      },
      top () {
        // if (this.$store.state.leodata.length > 1) { return false }
        if (window.lconfig.firstNodeAsTitle === false) { return false }
        return true
      },
      data () {
        return this.$store.state.leodata
      },
      text () {
        return this.$store.state.leotext
      }
    }

  }
</script>
<br/>
<!-- Add "scoped" attribute to limit CSS to this component only -->
<style lang="sass">
.treeviewer
  margin: 0
  height: 100%
  #left-pane
    ul
      list-style-type: none
      padding: 0
      padding-left: 10px
      line-height: 1.4em
      list-style-type: none
      margin-bottom: 8px
    li
      white-space: nowrap
      min-width: 760px
      margin-bottom: 4px
      margin-top: 4px
    li > div
      padding-left: 4px
</style>
