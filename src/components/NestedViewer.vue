<template>
  <div class="nestedviewer">
    <splitpane leftPaneStyle="width:360px">
      <ul slot="left">
        <div v-for="itemdata in data">
        <item
          class="item"
          :model="itemdata"
          :top="false"
          :textItems="text"
          :accordion="true"
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
    name: 'nestedviewer',
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
<style lang="sass">
.nestedviewer
  height: 100%
  margin-left: 6px
  .item-box
    border: 2px solid #ccc
    margin-right: 3px
    padding-left: 6px
    overflow: hidden
  ul
    list-style-type: none
    padding: 0
    padding-left: 0
    line-height: 1.4em
    list-style-type: none
    margin-bottom: 8px
  li
    white-space: nowrap
    margin-bottom: 4px
    margin-top: 4px
  li > div
    padding-left: 0
  .leaf-button
    width: 10px
    padding-left: 4px
    height: 10px
    display: inline-block
  .leaf-button::after
    content: '○'
</style>
