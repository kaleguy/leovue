
<template>
  <div class="treeviewer">
    <splitpane :leftPaneStyle="leftPaneStyle">
      <ul slot="left" class="left-pane" :style="ulStyle">
        <div v-for="itemdata in data">
        <item
          class="item"
          :model="itemdata"
          :top="top"
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
    computed: {
      ulStyle () {
        const p = window.lconfig.leftPanePadding || '0'
        return `padding-left:${p}`
      },
      leftPaneStyle () {
        const w = window.lconfig.leftPaneWidth || '420px'
        return `width:${w}`
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
