<template>
  <div class="panes-container">
    <div class="left-pane unselectable"
         :style="leftPaneStyle"
         id="left-pane">
      <div :style="{position:'relative', overflow: 'hidden', height: 'calc(100vh - 33px)'}">
        <div class="inner-container">
          <div style="height: calc(100vh - 33px)">
            <slot name="left"></slot>
          </div>
        </div>
      </div>
    </div>
    <div class="panes-separator"
         id="panes-separator">
      <div class="split-left"
           @click="slide('left')">
        <icon name="angle-double-left"></icon>
      </div>
      <div class="split-right"
           v-show="showRightButton"
           @click="slide('right')">
        <icon name="angle-double-right"></icon>
      </div>
    </div>
    <div id="right-pane" class="right-pane">
      <slot name="right"></slot>
    </div>
  </div>
</template>

<script>
  let leftPane
  let rightPane
  let paneSep
  export default {
    name: 'splitpane',
    props: {
      leftPaneStyle: String
    },
    data: function () {
      return {
        showRightButton: false,
        leftPaneWidth: 0
      }
    },
    methods: {
      slide: function (direction) {
        if (direction === 'left') {
          this.leftPaneWidth = leftPane.style.width
          leftPane.style.width = 0
          this.showRightButton = true
        } else {
          leftPane.style.width = this.leftPaneWidth
          this.showRightButton = false
        }
      }
    },
    computed: {
      xshowRightButton: function () {
        if (!leftPane) { return }
        return !leftPane.style.width
      }
    },
    mounted: function () {
      leftPane = document.getElementById('left-pane')
      rightPane = document.getElementById('right-pane')
      paneSep = document.getElementById('panes-separator')
      // The script below constrains the target to move horizontally between a left and a right virtual boundaries.
      // - the left limit is positioned at 10% of the screen width
      // - the right limit is positioned at 90% of the screen width
      const leftLimit = 0
      const rightLimit = 90

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
        let cur = pageX / window.innerWidth * 100
        if (cur < 0) {
          cur = 0
        }
        if (cur > window.innerWidth) {
          cur = window.innerWidth
        }
        let right = (100 - cur - 2)
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
  .panes-container {
    display: flex;
    width: 100%;
    height: 100%;
  }
  .left-pane {
    background: #fff;
    transition: width .3s
  }
  .panes-separator {
    width: 14px;
    background: #fcfcfc;
    position: relative;
    cursor: col-resize;
    background-image: url('../assets/vertical.png');
    background-repeat: no-repeat;
    background-position: 50% 46%;
    border-left: 1px solid #ddd;
    border-right: 1px solid #ddd;
  }
  .panes-container,
  .panes-separator,
  .left-pane,
  .right-pane {
    margin: 0;
    padding: 0;
  }
  .right-pane {
    width: 100%;
  }
  #left-pane {
    //overflow-y: auto;
    // padding-top: 33px;
  }
  .split-left, .split-right {
    margin-left: 0px;
    text-align: center;
    color: #999;
    cursor: pointer;
    width: 11px;
  }
  .split-left {
    margin-top: calc(50vh - 116px);
  }
  .split-right {
    margin-top: calc(128px);
  }
</style>
