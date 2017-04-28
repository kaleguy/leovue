<template>
    <div class="panes-container">
      <div class="left-pane unselectable"
           id="left-pane">
         <slot name="left"></slot>
      </div>
      <div class="panes-separator"
           id="panes-separator"></div>
      <div id="right-pane">
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
    data: function () {
      return {
      }
    },
    methods: {
    },
    computed: {
    },
    mounted: function () {
      leftPane = document.getElementById('left-pane')
      rightPane = document.getElementById('right-pane')
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
  .panes-container {
    display: flex;
    width: 100%;
    height: 100%;
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
  }
  .right-pane {
    flex: auto;
    background: #fff;
    padding:0px;
    padding-top: 10px;
    max-width: 620px;
    min-width: 500px;
  }
</style>
