<template>
  <div class="treeviewer">
    <splitpane leftPaneStyle="width:360px">
      <ul slot="left">
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

      top () {
        // console.log(this.$store.state.leodata)
        if (this.$store.state.leodata.length > 1) { return false }
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
<!-- Add "scoped" attribute to limit CSS to this component only -->
<style lang="sass">
.treeviewer
  margin-left: -10px
  height: 100%
  ul
    list-style-type: none;
    padding: 0;
    padding-left: 10px;
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
