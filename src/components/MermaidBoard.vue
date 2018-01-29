/* global YAML */
<template>
  <div
    class="mm-board">
    <div class="mbutton"
         @click="clickb"
         id="mbutton">
      <icon class="icon"
            v-if="!viewSource"
            name="code"></icon>
      <icon class="icon"
            v-if="viewSource"
            name="picture-o"></icon>
    </div>
    <h1>{{title}}</h1>
    <div
      v-if="!viewSource"
      @click="click">
      <mermaid
        :name=mmName
        :mm="mm"
        :height="mprops.height + ''">
        {{mm}}
      </mermaid>
    </div>
    <div class="content" v-if="viewSource" v-html="mmPretty"></div>
  </div>
</template>

<script>
  import Item from './Item'
  import _ from 'lodash'
  import yaml from 'js-yaml'
  const md = require('markdown-it')({
    html: true,
    linkify: true,
    typographer: true
  })

  // let itemSet = null
  function addParentPointers (item) {
    item.name = item.name.replace(/@mermaid\w\w /, '')
    item.children.forEach(c => {
      c.parent = item
      c.o = false
      addParentPointers(c)
    })
  }
  function getParentG (n) {
    if (!n) { return n }
    if (n.tagName === 'g' && n.id) {
      return n
    } else {
      return getParentG(n.parentElement)
    }
  }

  /**
   * If title doesn't have brackets, add them
   * @param title
   * @returns {*}
   */
  function cleanTitle (title, props) {
    let label = ''
    let m = title.match(/^(\|\w+?\|)/)
    if (m && m[1]) {
      label = m[1]
      title = title.replace(label, '')
    } else {
    }
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
    return { title, label }
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
      links.push(`mm${item.t}${pname.title} ${arrow} ${cname.label} mm${i.t}${cname.title};`)
      getMm(i, links, type, props)
    })
  }
  function getStyles (items, links, type, props) {
    getStyle(items.name, links, type, props, items.t)
    items.children.forEach(i => {
      getStyles(i, links, type, props)
    })
  }
  function getStyle (title, links, type, props, id) {
    if (!/[\[{(]/.test(title)) { // eslint-disable-line
      title = '[' + title + ']'
    }
    const firstChar = title[0]
    let fill = ''
    switch (firstChar) {
      case '[':
        fill = props.square.fill
        break
      case '(':
        if (title.slice(0, 2) === '((') {
          fill = props.circle.fill
        } else {
          fill = props.rounded.fill
        }
        break
      case '{':
        fill = props.rhombus.fill
        break
      default:
    }
    if (fill) {
      links.push(`style mm${id} fill:${fill}`)
    }
  }
/*
  function getClickHandlers (item, links, type, props, textItems) {
    item.children.forEach(i => {
      let text = textItems[i.t]
      links.push(`click ${i.t} noop "${text}"`)
      getClickHandlers(i, links, type, props, textItems)
    })
  }
*/
  export default {
    name: 'mermaid-board',
    components: {
      item: Item
    },
    methods: {
      main () {},
      clickb () {
        this.viewSource = !this.viewSource
      },
      click (e) {
        if (!e) { return null }
        if (e.target.id === 'mbutton') {
          return
        }
        const g = getParentG(e.target)
        if (!g) { return }
        // debugger
        // function show(id) {
        let text = this.$store.state.leotext[g.id.replace(/mm/, '')]
        text = md.render(text)
        if (!text) {
          text = '<div class="pop-small-text">No description for this node.</div>'
        }
        text = '<div class="pop-content">' + text + '</div>'
        document.getElementById('popover.content.html').innerHTML = text
        setTimeout(() => this.popover.show('#' + g.id), 10)
        // }
      }
    },
    data () {
      return {
        viewSource: false,
        mmPretty: ''
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
      mPretty: function () {
        return Math.random()
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
        let styles = []
        getStyles(this.itemSet, styles, graphType, this.mprops)
        links = links.concat(styles)
        links = _.uniq(links)
        links[0] = links[0].replace(/@mermaid\w? /, '')
        links = links.reverse()
        links.unshift('graph ' + graphType + ';')
        this.mmPretty = links.join('<br>')
        return links.join('\n')
      }
    },
    updated () {
      // hack to make Vue update mmPretty
      const foo = this.mm // eslint-disable-line
    },
    mounted () {
      console.log('mount')
      // thispopover = null // eslint-disable-line
      const me = this
      ons.createPopover('popover.html').then(function (element) { // eslint-disable-line
        me.popover = element
      })
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
.mbutton
  border: 1px solid #ccc
  border-radius: 2px
  width: 16px
  height: 18px
  position: absolute
  right: 6px
  top: 6px
  cursor: pointer
  padding-left: 2px
  padding-right: 2px
</style>
