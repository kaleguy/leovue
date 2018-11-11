<template>
  <div class="accordionviewer">
    <div class="panes-container">
      <div class="center-pane" id="center-pane">
        <ul :style="ulStyle">
          <div v-for="itemdata, index in data">
          <item
            class="item"
            :top="getTop(index)"
            :model="itemdata"
            :textItems="text"
            :targetEl="false"
            :open="false">
          </item>
          </div>
        </ul>
      </div>
    </div>
  </div>
</template>

<script>
  import Item from './Item'

  let target = {el: null}
  export default {
    name: 'accordionviewer',
    props: {
    },
    components: {
      item: Item
    },
    data: function () {
      return {
        target: target,
        open: false,
        active: false,
        lhandle: true
      }
    },
    methods: {
      getTop (index) {
        if (!index) {
          return this.top
        }
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
        return this.$store.state.leodata
      },
      text () {
        return this.$store.state.leotext
      },
      ulStyle () {
        const p = window.lconfig.leftPanePadding || '0'
        return `padding-left:${p}`
      },
      top () {
        // if (this.$store.state.leodata.length > 1) { return false }
        if (window.lconfig.firstNodeAsTitle === false) { return false }
        return true
      }
    },
    mounted: function () {
    }
  }
</script>
<!-- Add "scoped" attribute to limit CSS to this component only -->
<style>
  .accordionviewer{
    height: 100%;
    margin-top: 40px;
  }
  .accordionviewer UL {
    list-style-type: none;
  }
  .accordionviewer .panes-container {
    margin-left: 40px;
  }
</style>
