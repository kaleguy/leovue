<template>
  <div class="accordionviewer">
    <div class="panes-container">
      <div class="left-pane" id="left-pane">
        <ul id="demo">
          <item
            class="item"
            :showContentFlag="true"
            :model="data"
            :textItems="text"
            :open="true">
          </item>
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
      }
    },
    mounted: function () {
      this.$store.dispatch('loadLeo', {filename: 'docs'})
    }
  }
</script>
<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
  #vpane {
    width: 100%;
    background: #fff;
  }
  #tlayout {
    background: #fff;
    min-height: 100%;
    margin: 0;
    padding: 0;
  }
  .tlayout TD {
    padding: 0
  }

  .treeviewer{
    height: 100%
  }
  #lhandle {
    height: 100%;
    width: 40px;
    background: #fff;
    float:left;
  }
  #hshim {
    height: 10px;
  }
  h1, h2 {
    font-weight: normal;
  }

  ul {
    list-style-type: none;
    padding: 0;
  }

  li {
    display: inline-block;
    margin: 0 10px;
  }

  a {
    color: #42b983;
  }

  .panes-container {
    display: flex;
    width: 100%;
    overflow: hidden;
  }

  .left-pane {
    width: 250px;
    background: #fff;
  }
  .right-pane {
    max-width: 600px;
    min-width: 500px;
  }

  .panes-separator {
    width: 11px;
    background: #eee;
    position: relative;
    cursor: col-resize;
    /*background-image: url('../assets/vertical.png');*/
    background-repeat: no-repeat;
    background-position: 50%;
  }

  .right-pane {
    flex: auto;
    background: #fff;
  }

  .panes-container,
  .panes-separator,
  .left-pane,
  .right-pane {
    margin: 0;
    padding: 0;
    min-height: 100%;
  }
  .right-pane {
    padding:0px;
    padding-top:0px;
  }
  p {
    line-height:1.3em;
  }

</style>
