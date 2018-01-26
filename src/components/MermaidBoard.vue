/* global YAML */
<template>
  <div class="mm-board">
    <h1>{{title}}</h1>
    <mermaid
      :name=mmName
      :mm="mm"
      :height="mprops.height">
      {{mm}}
    </mermaid>
  </div>
</template>

<script>
  import Item from './Item'
  import _ from 'lodash'
  import yaml from 'js-yaml'
  // let itemSet = null
  function addParentPointers (item) {
    item.name = item.name.replace(/@mermaid\w\w /, '')
    item.children.forEach(c => {
      c.parent = item
      c.o = false
      addParentPointers(c)
    })
  }

  /**
   * If title doesn't have brackets, add them
   * @param title
   * @returns {*}
   */
  function cleanTitle (title, props) {
    if (!/[\[{(]/.test(title)) { // eslint-disable-line
      title = '[' + title + ']'
    }
    const firstChar = title[0]
    switch (firstChar) {
      case '[':
        title = setFa(title, 'square', 1)
        break
      case '(':
        if (title.slice(0, 2) === '((') {
          title = setFa(title, 'circle', 2)
        } else {
          title = setFa(title, 'rounded', 1)
        }
        break
      case '<':
        title = setFa(title, 'rhombus', 1)
        break
      default:
    }
    return title
    function setFa (title, shape, count) {
      if (!props[shape].fa) {
        return title
      }
      title = title.slice(0, count) + 'fa:fa-' + props[shape].fa + ' ' + title.slice(count)
      return title
    }
  }
  function getMm (item, links, type, props) {
    let arrow = '-->'
    if (type === 'RL') {
      arrow = '---'
    }
    item.children.forEach(i => {
      let pname = cleanTitle(item.name, props)
      let cname = cleanTitle(i.name, props)
      links.push(`${item.t}${pname} ${arrow} ${i.t}${cname}`)
      getMm(i, links, type, props)
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
      mprops: function () {
        const props = {
          height: 600,
          circle: {
            fill: '',
            fa: ''
          },
          square: {
            fill: '',
            fa: ''
          },
          rounded: {
            fill: '',
            fa: ''
          },
          rhombus: {
            fill: '',
            fa: ''
          }
        }
        const tprops = yaml.safeLoad(this.text) // eslint-disable-line
        _.merge(props, tprops)
        return props
      },
      data () {
        return this.$store.state.leodata
      },
      item () {
        const id = this.$store.state.currentItem.id
        return JSON.search(this.data, '//*[id="' + id + '"]')[0]
      },
      title () {
        return this.item.name.replace(/@mermaid\w\w /, '').replace(/^\(/, '').replace(/\)$/, '')
      },
      mmName () {
        return this.item.name
      },
      text () {
        return this.$store.state.leotext[this.item.t]
      },
      itemSet () {
        // if (!itemSet) {
        let itemSet = _.cloneDeep(this.item)
        addParentPointers(itemSet)
        // }
        return itemSet
      },
      mm () {
        let graphType = 'LR'
        let m = this.item.name.match(/@mermaid([a-z][a-z])/)
        if (m) {
          graphType = m[1].toUpperCase()
        }
        let links = []
        getMm(this.itemSet, links, graphType, this.mprops)
        links = _.uniq(links)
        links[0] = links[0].replace(/@mermaid\w? /, '')
        links.unshift('graph ' + graphType + ';')
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
.mm-board
  margin-left: 20px
.mermaid
  text-align: center
  // margin-left: auto
  // margin-right: auto
</style>
