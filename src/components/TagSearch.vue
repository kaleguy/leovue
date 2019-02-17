<template>
  <div>
    <vue-tags-input
      v-model="tag"
      :tags="tags"
      @tags-changed="newTags => tags = newTags"
      :autocomplete-items="filteredItems"
    />
    <div class="hit-list">
    <div v-for="chapter in chapters" class="chapter">
      <div class="section-link"
           @click="gotoSection(chapter.vtitle)">{{chapter.vtitle}}</div>
    </div>
    </div>
  </div>
</template>

<script>
  import VueTagsInput from '@johmun/vue-tags-input'
  import util from '../util'
  import _ from 'lodash'
  export default {
    name: 'tagsearch',
    components: {
      VueTagsInput
    },
    data () {
      return {
        tag: '',
        tags: [
        ]
      }
    },
    computed: {
      chapters () {
        const leodata = this.$store.state.leodata
        if (!this.tags.length) { return }
        const conditions = this.tags.map(tag => { return `[tags/text="${tag.text}"]` }).join('')
        const nodes = JSON.search(leodata, `//*${conditions}`)
        return nodes
      },
      filteredItems () {
        const tags = this.$store.state.tags
        const tagList = tags.reduce((acc, curr) => {
          acc.push({ text: curr })
          return acc
        }, [])
        const tag = this.tag.toLowerCase()
        console.log(this.tags)
        return tagList.filter(i => {
          return i.text.toLowerCase().indexOf(tag) !== -1
        })
      }
    },
    methods: {
      // TODO this is duplicate of TOC method, move to util
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
    }
  }
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style lang="sass" scoped>
.hit-list
  margin-top: 30px
.chapter
  margin-top: 10px
  .section-link
    color: #4cb986
    font-weight: bold
    cursor: pointer
    text-decoration: none
    display: block
  // margin-bottom: 1rem
</style>
