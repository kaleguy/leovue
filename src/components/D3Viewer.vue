<template>
  <div class="treeviewer">
    <splitpane leftPaneStyle="width:500px">
      <div slot="left">
          <d3tree
                  style="height:680px"
                  :openDepth="2"
                  ref="tree" :zoomable="zoomable" :data="data" :node-text="nodeText"
                  :margin-x="Marginx" :margin-y="Marginy" :type="type"
                  :layout-type="layoutType" :duration="duration"
                  @clicked="onClick"
                  class="tree"></d3tree>

      </div>
      <contentpane slot="right"></contentpane>
    </splitpane>
  </div>
</template>

<script>
  import D3tree from '../lib/D3tree'
  import SplitPane from './SplitPane'
  import ContentPane from './ContentPane'

  let target = {el: null}
  export default {
    name: 'd3viewer',
    props: {
    },
    components: {
      D3tree,
      splitpane: SplitPane,
      contentpane: ContentPane
    },
    data: function () {
      return {
        target: target,
        open: false,
        active: false,
        lhandle: true,
        type: 'tree',
        layoutType: 'euclidean',
        duration: 750,
        Marginx: 60,
        Marginy: 30,
        nodeText: 'name',
        currentNode: null,
        zoomable: true,
        isLoading: false,
        events: []
      }
    },
    methods: {
      onClick (evt) {
        this.currentNode = evt.element
        this.onEvent('onClick', evt)
      },
      onEvent (eventName, data) {
        this.events.push({eventName, data: data.data})
        const id = data.data.id
        this.$store.dispatch('setCurrentItem', {id})
      }
    },
    watch: {
      '$route': {
        handler: function (val, oldVal, changed) {
        //  this.id = val.params.id
        },
        immediate: true
      }
    },
    computed: {
      data () {
        // console.log('D', this.$store.state.leodata)
        return this.$store.state.leodata
      },
      text () {
        return this.$store.state.leotext
      },
      layoutType () {
        return 'd'
      }
    },
    mounted: function () {
    }
  }
</script>
<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
  .d3viewer {
    height: 100%;
    width: 100%;
  }
</style>
