<template>
  <div class="section-link"
       @click="gotoSection">« {{title}} »</div>
</template>

<script>
  import _ from 'lodash'
  import util from '../util'
  export default {
    name: 'sectionlink',
    props: {
      title: String
    },
    data () {
      return {
      }
    },
    methods: {
      gotoSection: function () {
        const plainTitle = _.trim(this.title)
        const searchTitle = '« ' + plainTitle + ' »'
        let leodata = this.$store.state.leodata
        if (window.parent !== window.self) {
          leodata = window.parent.lconfig.leodata
        }
        let titleObj = JSON.search(leodata, '//*[name="' + searchTitle + '"]')[0]
        if (!titleObj) {
          titleObj = util.getObjectByKeyFromTree(leodata[0], 'name', plainTitle)
          console.log(titleObj)
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
.section-link
  color: #4cb986
  font-weight: bold
  cursor: pointer
  text-decoration: none
  display: inline-block
</style>
