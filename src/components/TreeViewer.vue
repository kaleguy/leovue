<template>
  <div class="treeviewer">
    <splitpane leftPaneStyle="width:360px">
      <ul slot="left">
        <item
          class="item"
          :model="data"
          :top="true"
          :textItems="text"
          :targetEl="target.el">
        </item>
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
<style scoped>
  .treeviewer{
    height: 100%
  }
  ul {
    list-style-type: none;
    padding: 0;
    padding-left: 10px;
  }
</style>
