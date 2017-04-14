<template>
  <div class="treeviewer">
    <div class="panes-container">
      <div class="left-pane" id="left-pane">
        <ul id="demo">
          <item
            class="item"
            :showContentFlag="true"
            :model="data"
            :top="true"
            :textItems="text"
            :open="true"
            :targetEl="target.el"
            :vTargetEl="target.v">
          </item>
        </ul>
      </div>
      <div class="panes-separator" id="panes-separator"></div>
      <div v-show="textContent" id="tlayout">
        <div id="lhandle" class="handle">
          <div class="handle-button" v-show="hasPrev">
            <icon class="icon" name="chevron-left"></icon>
          </div>
        </div>
        <div class="right-pane" id="right-pane"></div>
        <div id="rhandle" class="handle">
          <div class="handle-button" v-show="hasNext">
            <icon class="icon" name="chevron-right"></icon>
          </div>
        </div>
      </div>
      <div v-show="iframeContent" style='min-height:100%' id="vpane"></div>
    </div>
  </div>
</template>

<script>
  import Item from './Item'

  let leftPane
  let vPane
  let rightPane
  let paneSep
  let target = {el: null, v: null}
  export default {
    name: 'treeviewer',
    props: {
      id: 0
    },
    components: {
      item: Item
    },
    data: function () {
      return {
        target: target,
        open: false,
        active: false,
        lhandle: true,
        rightSibling: null
      }
    },
    watch: {
      '$route': {
        handler: function (val, oldVal, changed) {
          this.id = val.params.id
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
      iframeContent () {
        if (this.$store.state.contentPane === 'site') {
          return true
        } else {
          return false
        }
      },
      textContent () {
        if (this.$store.state.contentPane === 'text') {
          return true
        } else {
          return false
        }
      },
      hasNext () {
        return this.$store.state.currentItem.hasNext
      },
      hasPrev () {
        return this.$store.state.currentItem.hasPrev
      }
    },
    mounted: function () {
      leftPane = document.getElementById('left-pane')
      vPane = document.getElementById('vpane')
      rightPane = document.getElementById('right-pane')
      target.el = rightPane // regular content
      target.v = vPane  // iframe content
      paneSep = document.getElementById('panes-separator')
      rightPane.innerHTML = ''

      // The script below constrains the target to move horizontally between a left and a right virtual boundaries.
      // - the left limit is positioned at 10% of the screen width
      // - the right limit is positioned at 90% of the screen width
      var leftLimit = 0
      var rightLimit = 90

      paneSep.sdrag(function (el, pageX, startX, pageY, startY, fix) {
        fix.skipX = true
        if (pageX < window.innerWidth * leftLimit / 100) {
          pageX = window.innerWidth * leftLimit / 100
          fix.pageX = pageX
        }
        if (pageX > window.innerWidth * rightLimit / 100) {
          pageX = window.innerWidth * rightLimit / 100
          fix.pageX = pageX
        }
        var cur = pageX / window.innerWidth * 100
        if (cur < 0) {
          cur = 0
        }
        if (cur > window.innerWidth) {
          cur = window.innerWidth
        }
        var right = (100 - cur - 2)
        leftPane.style.width = cur + '%'
        rightPane.style.width = right + '%'
      }, null, 'horizontal')
      this.$store.dispatch('loadLeo', {filename: 'docs', id: this.id})
    },
    updated () {
      const selectedItem = this.$route.params.id
      var reds = JSON.search(this.data, '//*[id="' + selectedItem + '"]/ancestor::*')
      console.log(selectedItem, reds)
    }
  }
</script>
<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
  #vpane {
    width: 100%;
    background: #fff;
  }
  .right-pane {
    max-width: 620px;
    min-width: 500px;
  }
  #tlayout {
    background: #fff;
    min-height: 100%;
    margin: 0;
    padding: 0;
    display: flex;
    flex-wrap: nowrap;
  }
  .tlayout TD {
    padding: 0
  }

  .treeviewer{
    height: 100%
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
  .handle-button {
    height:20px;
    width: 20px;
    margin-left: auto;
    margin-right: auto;
    cursor: pointer;
    text-align: center;
    position: fixed;
    top: 50%;
    transform: translateY(-50%);
    color: #ccf;
    margin-left: 9px;
  }
  .handle {
    width:50px;
    align-items: center;
    flex: auto;
    display: flex;
  }
  #lhandle {
    height: 100%;
    min-width: 50px;
    background: #fff;
  }
</style>
