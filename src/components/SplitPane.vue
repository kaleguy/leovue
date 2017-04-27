<template>
    <div class="panes-container">
      <div class="left-pane unselectable" id="left-pane">
LEFT
      </div>
      <div class="panes-separator"
           id="panes-separator"></div>
      <div v-show="textContent"
           id="tlayout">
        <div id="lhandle"
             class="handle">
          <div class="handle-button"
               v-show="hasPrev"
               @click="goPrev">
            <icon class="icon"
                  name="chevron-left"></icon>
          </div>
        </div>
        <div class="right-pane"
             v-html="currentItemContent"></div>
        <div id="rhandle"
             class="handle">
          <div class="handle-button"
               v-show="hasNext"
               @click="goNext">
            <icon class="icon"
                  name="chevron-right"></icon>
          </div>
        </div>
      </div>
      <div v-show="iframeContent" style="min-height:100%; display:flex; background:#fff" id="vpane"></div>
    </div>
</template>

<script>

  let leftPane
  let vPane
  let rightPane
  let paneSep
  let target = {el: true, v: null}
  export default {
    name: 'splitpane',
    components: {
    },
    data: function () {
      return {
      }
    },
    methods: {
      goNext () {
        const next = this.$store.state.currentItem.next
        this.resetCurrentItem(next)
      },
      goPrev () {
        const prev = this.$store.state.currentItem.prev
        this.resetCurrentItem(prev)
      },
      resetCurrentItem (id) {
        router.replace('/t/' + id)
        const currentItem = { id }
        this.$store.commit('RESET')
        this.$store.commit('CURRENT_ITEM', currentItem)
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
      currentItemContent () {
        // console.log('xxxx', this.$store.state.currentItemContent)
        return this.$store.state.currentItemContent
      },
      hasNext () {
        return this.$store.state.currentItem.next
      },
      hasPrev () {
        return this.$store.state.currentItem.prev
      }
    },
    mounted: function () {
      // TODO: clean up targets
      leftPane = document.getElementById('left-pane')
      vPane = document.getElementById('vpane')
      rightPane = document.getElementById('right-pane')
      target.v = vPane  // iframe content
      paneSep = document.getElementById('panes-separator')

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
    },
    updated () {
    }
  }
</script>
<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
  #vpane {
    width: 100%;”
    background: #fff;
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
  .panes-container,
  .panes-separator,
  .left-pane,
  .right-pane {
    margin: 0;
    padding: 0;
    min-height: 100%;
  }
  .right-pane {
    flex: auto;
    background: #fff;
    padding:0px;
    padding-top: 10px;
    max-width: 620px;
    min-width: 500px;
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
