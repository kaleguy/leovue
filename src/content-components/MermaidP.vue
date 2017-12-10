<template>
    <div class="xmermaid">
      <div><slot></slot></div>
      <div id="id1" style="display:none"></div>
    </div>
</template>

<script>
  /* global d3, mermaid */
  export default {
    name: 'mermaidp',
    components: {
    },
    props: {
      height: {
        type: String,
        default: '300'
      },
      width: {
        type: String,
        default: '400'
      }
    },
    methods: {
    },
    data () {
      return {
      }
    },
    beforeCreate () {
    },
    mounted () {
      const mermaidEl = this.$el // document.getElementsByClassName('mermaid')[0]
      mermaidEl.style.width = this.width + 'px'
      mermaidEl.style.height = this.height + 'px'
      mermaidEl.style.width = this.width + 'px'
      const mermaidGraphDefinition = mermaidEl.firstElementChild.innerHTML.replace(/&gt;/g, '>')
      console.log('MG', mermaidGraphDefinition)
      // mermaid.init(undefined, mermaidEl) // eslint-disable-line
      function draw () {
        let graphDefinition = 'graph TB\na-->b' // eslint-disable-line
        let cb = function (svgGraph) { // eslint-disable-line
          svgGraph = svgGraph.replace(/svg {/, 'avg') // hack to get rid of style in <style> tag
          mermaidEl.firstElementChild.innerHTML = svgGraph
          const svgEl = mermaidEl.firstElementChild.firstElementChild
          console.log(svgEl)
          d3.select(svgEl)
            .insert('rect', ':first-child')
            .attr('width', '100%')
            .attr('height', '100%')
            .attr('fill', 'white')
          d3.select(svgEl)
            .style('max-width', null)
            .style('font-size', '14px')
            .style('color', '#000')
        }
        mermaid.render('mm1', mermaidGraphDefinition, cb) // eslint-disable-line
      }
      draw()
    },
    computed: {
      id: function () {
      }
    }
  }
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style lang="sass" scoped>
.xmermaid
  margin-left: auto
  margin-right: auto
</style>
