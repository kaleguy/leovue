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
           @click="gotoSection(chapter.node.id)">{{chapter.nodePath}} {{chapter.node.vtitle}}</div>
    </div>
    </div>
  </div>
</template>

<script>
  import VueTagsInput from '@johmun/vue-tags-input'
  import util from '../util'
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
        const arr = []
        let nodes = JSON.search(leodata, `//*${conditions}`)
        nodes.forEach(node => {
          const nodePath = util.getNodePath(leodata, node)
          arr.push({ nodePath, node })
        })
        return arr
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
      gotoSection: function (id) {
        this.$store.dispatch('setCurrentItem', {id})
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
