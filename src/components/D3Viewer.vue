<template>
  <div>
    <div>
      <d3tree ref="tree" :zoomable="zoomable" :data="data" :node-text="nodeText"
              :margin-x="Marginx" :margin-y="Marginy" :type="type"
              :layout-type="layoutType" :duration="duration"
              class="tree"></d3tree>
    </div>
  </div>
</template>

<script>
  import D3tree from '../lib/D3tree'

  let target = {el: null}
  export default {
    name: 'd3viewer',
    props: {
    },
    components: {
      D3tree
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
        Marginx: 100,
        Marginy: 30,
        nodeText: 'name',
        currentNode: null,
        zoomable: true,
        isLoading: false,
        events: []
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
      }
    },
    mounted: function () {
    }
  }
</script>
<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
  .tree {
    height: 600px;
    width: 100%;
  }
</style>
