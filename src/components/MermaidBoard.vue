<template>
  <div style="text-align:center">
    <h1>{{title}}</h1>
    <mermaid height="300">
      {{mm}}
    </mermaid>
  </div>
</template>

<script>
  import Item from './Item'
  import _ from 'lodash'
  // let itemSet = null
  function addParentPointers (item) {
    item.name = item.name.replace(/@mermaid/, '')
    item.children.forEach(c => {
      c.parent = item
      c.o = false
      addParentPointers(c)
    })
  }
  function getMm (item, links) {
    item.children.forEach(i => {
      links.push(`${item.id}[${item.name}] --> ${i.id}[${i.name}]`)
      getMm(i, links)
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
      //  links: []
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
        return this.item.name.replace(/@mermaid /, '')
      },
      text () {
        return this.$store.state.leotext
      },
      itemSet () {
        // if (!itemSet) {
        let itemSet = _.cloneDeep(this.item)
        addParentPointers(itemSet)
        // }
        return itemSet
      },
      mm () {
        const links = []
        getMm(this.itemSet, links)
        links[0] = links[0].replace(/@mermaid /, '')
        links.unshift('graph TD;')
        console.log('LINKs:', links)
        return links.join('\n')

        /*        `
              graph TD;
              Anything-->B;
              Everything-->C;
              B-->D;
              C-->D;
        ` */
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

</style>
