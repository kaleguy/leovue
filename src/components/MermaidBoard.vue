<template>
  <div style="color:#fff">
    <h1>HI MOM</h1>
    <mermaid height="300" width="250">

      {{mm}}

    </mermaid>
  </div>
</template>

<script>
  import Item from './Item'
  import _ from 'lodash'
  let itemSet = null
  function addParentPointers (item) {
    item.children.forEach(c => {
      c.parent = item
      c.o = false
      addParentPointers(c)
    })
  }
  export default {
    name: 'mermaid-board',
    components: {
      item: Item
    },
    methods: {
      main () {}
    },
    data () {
      return {
      }
    },
    computed: {
      id: function () {
        if (!this.$route.params.id) {
          return +1
        } else {
          return this.$route.params.id
        }
      },
      data () {
        return this.$store.state.leodata
      },
      item () {
        const id = this.$store.state.currentItem.id
        return JSON.search(this.data, '//*[id="' + id + '"]')[0]
      },
      title () {
        return this.item.name.replace(/@kanban /, '')
      },
      text () {
        return this.$store.state.leotext
      },
      itemSet () {
        if (!itemSet) {
          itemSet = _.cloneDeep(this.item)
          addParentPointers(itemSet)
        }
        return itemSet
      },
      mm () {
        return `
              graph TD;
              Anything-->B;
              Everything-->C;
              B-->D;
              C-->D;
        `
      }
    },
    mounted () {
    },
    watch: {
      '$route' (to, from) {
        // console.log(to, from)
      }
    }
  }
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style lang="sass" scoped>
  H1
    margin: 0
    margin-left: 10px
</style>
<style lang="sass">
.flex-grid
  display: flex
  background: #117ABD
  height: 90%
  position: relative
  padding-right: 10px
.col
  flex: 1
  background: #fff
  border-radius: 6px
  margin-left: 10px
  // margin-top: 10px
  margin-bottom: 10px
  padding: 10px
  background: #eee
  color: #000
.col-title
  font-weight: bold
  font-size: 18px
.nestedviewer
  height: 100%
  // margin-left: 6px
  background: #117ABD
  .item-box
    border: 2px solid #ccc
    margin-right: 3px
    padding-left: 6px
    padding-right: 6px
    overflow: hidden
    background: #fff
  ul
    list-style-type: none
    padding: 0
    padding-left: 0
    line-height: 1.4em
    list-style-type: none
    margin-bottom: 8px
  li
    white-space: nowrap
    margin-bottom: 4px
    margin-top: 4px
  li > div
    padding-left: 0
  .leaf-button
    width: 10px
    padding-left: 4px
    height: 10px
    display: inline-block
  .leaf-button::after
    content: '○'

</style>
