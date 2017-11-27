<template>
    <div class="reveal">
      <component :is="currentContent"/>
      </div>
    </div>
</template>

<script>
  export default {
    name: 'appBase',
    data: function () {
      return {
        slideContent: '',
        initialized: false,
        currentContent: null
      }
    },
    methods: {
    },
    mounted () {
      // let filename = 'static/docs'
      if (window.lconfig.filename) {
      //  filename = window.lconfig.filename
      }
      // console.log('LOADING APP BASE')
      if (!this.$store.initializedData) {
      //  this.$store.dispatch('loadLeo', {filename, route: this.$route})
      }
      // const slideContent = document.getElementById('slideContent').innerHTML
      // this.slideContent = slideContent
      this.currentContent = this.dynComponent
      // Reveal.initialize({}) // eslint-disable-line
    },
    updated () {
      if (!this.initialized) {
        // Reveal.initialize({}) // eslint-disable-line
      }
      this.initialized = true
    },
    computed: {
      dynComponent () {
        const content = document.getElementById('slideContent').innerHTML
        const template = `<div class="slides">${content}</div>`
        return {
          template, // use content as template for this component
          mounted () {
            Reveal.initialize({ // eslint-disable-line
              controls: true,
              progress: true,
              center: true,
              transition: 'slide', // none/fade/slide/convex/concave/zoom
              // More info https://github.com/hakimel/reveal.js#dependencies
              dependencies: [
                { src: 'plugin/zoom-js/zoom.js', async: true },
                { src: 'plugin/notes/notes.js', async: true }
              ]
            })
          }
        }
      }
    }

  }
</script>

<style lang="sass">

@import './assets/global.sass'
@import './assets/vue-instant.css'
@import '~leaflet/dist/leaflet.css'

$mycolor: #2c3e50

HTML, BODY
  margin: 0
  padding: 0
  height: 100%
  width: 100%

H1
  margin: 4px

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
  // height: 100%
  white-space: pre-line
  width: 100%

.directive
  color: #990000

.md
  margin-left: 10px
  margin-top: 10px
  max-width: 700px
  padding-right: 10px

.unselectable
 -moz-user-select: -moz-none
 -khtml-user-select: none
 -webkit-user-select: none
 //  Introduced in IE 10.
 //  See http://ie.microsoft.com/testdrive/HTML5/msUserSelect/
 -ms-user-select: none
 user-select: none

A, .link
  color: #42b983
  cursor: pointer
  text-decoration: underline

.flip-container
  width: 80%
  max-width: 600px
  margin-left: 40px
  margin-bottom: 60px
  SVG
    height: inherit !important

</style>
