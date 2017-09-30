<template>
  <div style="height:100%;width:100%'">
    <grid-layout
      :layout="layout"
      :col-num="12"
      :row-height="30"
      :is-draggable="true"
      :is-resizable="true"
      :vertical-compact="true"
      :margin="[10, 10]"
      :use-css-transforms="true"
    >
      <grid-item
       :x="tbox.x"
       :y="tbox.y"
       :w="tbox.w"
       :h="tbox.h"
       :i="tbox.i">
        <ul>
          <div v-for="itemdata in data">
          <item
            class="item"
            :model="itemdata"
            :top="true"
            :textItems="text"
            :targetEl="target.el">
          </item>
          </div>
        </ul>
      </grid-item>
      <grid-item
        :x="cbox.x"
        :y="cbox.y"
        :w="cbox.w"
        :h="cbox.h"
        :i="cbox.i">
        <contentpane></contentpane>
      </grid-item>
    </grid-layout>
  </div>
</template>

<script>
  import VueGridLayout from 'vue-grid-layout'
  import Item from './Item'
  import ContentPane from './ContentPane'

  const layout = [
    {'x': 0, 'y': 0, 'w': 4, 'h': 4, 'i': '0'},
    {'x': 4, 'y': 0, 'w': 8, 'h': 4, 'i': '1'}
  ]

  const GridLayout = VueGridLayout.GridLayout
  const GridItem = VueGridLayout.GridItem
  const target = {el: true, v: null}

  export default {
    name: 'dbviewer',
    components: {
      GridLayout,
      GridItem,
      item: Item,
      contentpane: ContentPane
    },
    props: {
      panelHeight: {
        type: Number,
        default: 16.5
      }
    },
    data () {
      return {
        layout, target
      }
    },
    computed: {
      data () {
        return this.$store.state.leodata
      },
      text () {
        return this.$store.state.leotext
      },
      xlayout () {
        // layout.forEach(l => { l.h = 10 })
        return layout
      },
      tbox () {
        this.layout[0].h = this.panelHeight
        return this.layout[0]
      },
      cbox () {
        this.layout[1].h = this.panelHeight
        return this.layout[1]
      }
    },
    mounted () {
      // this.panelHeight = 8
    }

  }
</script>
<!-- Add 'scoped' attribute to limit CSS to this component only -->
<style>
  .vue-resizable-handle {
    z-index: 5000;
    position: absolute;
    width: 20px;
    height: 20px;
    bottom: 0;
    right: 0;
    background: url('data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBzdGFuZGFsb25lPSJubyI/Pg08IS0tIEdlbmVyYXRvcjogQWRvYmUgRmlyZXdvcmtzIENTNiwgRXhwb3J0IFNWRyBFeHRlbnNpb24gYnkgQWFyb24gQmVhbGwgKGh0dHA6Ly9maXJld29ya3MuYWJlYWxsLmNvbSkgLiBWZXJzaW9uOiAwLjYuMSAgLS0+DTwhRE9DVFlQRSBzdmcgUFVCTElDICItLy9XM0MvL0RURCBTVkcgMS4xLy9FTiIgImh0dHA6Ly93d3cudzMub3JnL0dyYXBoaWNzL1NWRy8xLjEvRFREL3N2ZzExLmR0ZCI+DTxzdmcgaWQ9IlVudGl0bGVkLVBhZ2UlMjAxIiB2aWV3Qm94PSIwIDAgNiA2IiBzdHlsZT0iYmFja2dyb3VuZC1jb2xvcjojZmZmZmZmMDAiIHZlcnNpb249IjEuMSINCXhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgeG1sbnM6eGxpbms9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGxpbmsiIHhtbDpzcGFjZT0icHJlc2VydmUiDQl4PSIwcHgiIHk9IjBweCIgd2lkdGg9IjZweCIgaGVpZ2h0PSI2cHgiDT4NCTxnIG9wYWNpdHk9IjAuMzAyIj4NCQk8cGF0aCBkPSJNIDYgNiBMIDAgNiBMIDAgNC4yIEwgNCA0LjIgTCA0LjIgNC4yIEwgNC4yIDAgTCA2IDAgTCA2IDYgTCA2IDYgWiIgZmlsbD0iIzAwMDAwMCIvPg0JPC9nPg08L3N2Zz4=');
    background-position: bottom right;
    padding: 0 3px 3px 0;
    background-repeat: no-repeat;
    background-origin: content-box;
    box-sizing: border-box;
    cursor: se-resize;
  }

  .vue-grid-item:not(.vue-grid-placeholder) {
    background: #fff;
    border: 1px solid black;
  }

  .vue-grid-item.resizing {
    opacity: 0.9;
  }

  .vue-grid-item.static {
    background: #fff;
  }

  .xvue-grid-item .text {
    font-size: 24px;
    text-align: center;
    position: absolute;
    top: 0;
    bottom: 0;
    left: 0;
    right: 0;
    margin: auto;
    height: 24px;
  }

  .vue-grid-item .minMax {
    font-size: 12px;
  }

  .vue-grid-item .add {
    cursor: pointer;
  }
  .vue-grid-item .right-cpane {
    height: auto;
  }
  .vue-grid-item .pane {
    overflow: scroll;
  }
  .vue-grid-item {
    overflow: scroll;
  }


</style>
