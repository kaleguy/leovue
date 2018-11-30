<template>
  <div>
    <div v-for="chapter in chapters" class="chapter">
         <div class="section-link"
         @click="gotoSection(chapter.vtitle)">« {{chapter.vtitle}} »</div>
  </div>
  </div>
</template>

<script>
  import _ from 'lodash'
  import util from '../util'
  export default {
    name: 'toc',
    props: {
    },
    data () {
      return {
      }
    },
    computed: {
      chapters () {
        let data = this.$store.state.leodata
        const item = JSON.search(data, '//*[id="' + this.$store.state.currentItem.id + '"]')[0]
        return item.children
        // return this.$store.state.viewType
      }
    },
    methods: {
      gotoSection: function (title) {
        const plainTitle = _.trim(title)
        const searchTitle = '« ' + plainTitle + ' »'
        let leodata = this.$store.state.leodata
        if (window.parent !== window.self) {
          leodata = window.parent.lconfig.leodata
        }
        let titleObj = JSON.search(leodata, '//*[vtitle="' + searchTitle + '"]')[0]
        if (!titleObj) {
          let i = 0
          while (!titleObj && (i < leodata.length)) {
            titleObj = util.getObjectByKeyFromTree(leodata[i], 'vtitle', plainTitle)
            i = i + 1
          }
        }
        let id = null
        let index = null
        if (titleObj) {
          id = titleObj.id
          if (titleObj.index) {
            index = titleObj.index
          }
          this.$store.dispatch('setCurrentItem', {id})
          if (window.parent !== window.self) {
            console.log('posting message')
            window.parent.postMessage(JSON.stringify({
              namespace: 'leovue',
              eventName: 'setcurrentitem',
              state: {id, index}
            }), '*')
          }
        }
      }
    },
    components: {}
  }
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style lang="sass" scoped>
.chapter
  margin: 6px
.section-link
  color: #4cb986
  font-weight: bold
  cursor: pointer
  text-decoration: none
  display: block
  // margin-bottom: 1rem
</style>
