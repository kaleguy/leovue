<template>
  <div id="app"
       @drop="drop_handler($event);"
       @dragover="dragover_handler($event);"
       @dragend="dragend_handler($event);">
    <router-view></router-view>
  </div>
</template>

<script>
  export default {
    name: 'app',
    methods: {
      dragover_handler (ev) {
        // Prevent default select and drag behavior
        ev.preventDefault()
      },
      dragend_handler (ev) {
        // Remove all of the drag data
        var dt = ev.dataTransfer
        if (dt.items) {
          // Use DataTransferItemList interface to remove the drag data
          for (var i = 0; i < dt.items.length; i++) {
            dt.items.remove(i)
          }
        } else {
          // Use DataTransfer interface to remove the drag data
          ev.dataTransfer.clearData()
        }
      },
      drop_handler (ev) {
        ev.preventDefault()
        // If dropped items aren't files, reject them
        var dt = ev.dataTransfer
        var i
        var f
        if (dt.items) {
          // Use DataTransferItemList interface to access the file(s)
          for (i = 0; i < dt.items.length; i++) {
            if (dt.items[i].kind === 'file') {
              f = dt.items[i].getAsFile()
            }
          }
        } else {
          // Use DataTransfer interface to access the file(s)
          for (i = 0; i < dt.files.length; i++) {
            f = dt.files[i]
          }
        }
        var reader = new FileReader()
        reader.onload = (xml) => {
          const xmlString = xml.srcElement.result
          this.$store.dispatch('loadLeoFromXML', {xml: xmlString, route: this.$route})
        }
        reader.readAsText(f)
      }

    },
    mounted () {
      let filename = 'docs'
      if (window.lconfig.filename) {
        filename = window.lconfig.filename
      }
      this.$store.dispatch('loadLeo', {filename, id: this.id, route: this.$route})
    }
  }
</script>

<style lang="sass">

$mycolor: #2c3e50

HTML, BODY
  margin: 0
  padding: 0
  height: 100%
  width: 100%

#app
  font-family: Avenir, Nunito, Helvetica, Arial, sans-serif
  -webkit-font-smoothing: antialiased
  -moz-osx-font-smoothing: grayscale
  color: $mycolor
  margin: 0
  padding: 0
  height: 100%

.right-pane .text, .inline .text
  margin-top: 20px
  border: none
  background-color: transparent
  resize: none
  outline: none
  font-size: 16px
  height: 100%
  white-space: pre-line
  width: 100%

.directive
  color: #990000;

.md
  margin-left: 40px
  margin-top: 10px
  max-width: 600px

.unselectable
 -moz-user-select: -moz-none
 -khtml-user-select: none
 -webkit-user-select: none
 //  Introduced in IE 10.
 //  See http://ie.microsoft.com/testdrive/HTML5/msUserSelect/
 -ms-user-select: none
 user-select: none


</style>
