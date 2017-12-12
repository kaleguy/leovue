<template>
    <div class="xmermaid">
       <slot></slot>
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
        type: String
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
      /**
      const config = {
        startOnLoad: true,
        flowchart: {
          useMaxWidth: false,
          htmlLabels: true
        },
        theme: 'forest'
      }
      */
      // mermaid.initialize(config)
      const mermaidEl = this.$el // document.getElementsByClassName('mermaid')[0]
      if (this.width) {
        mermaidEl.style.width = this.width + 'px'
      }
      mermaidEl.style.height = this.height + 'px'
      const mermaidGraphDefinition = mermaidEl.innerHTML.replace(/&gt;/g, '>')
      function draw () {
        let cb = function (svgGraph) {
          svgGraph = svgGraph.replace(/svg {/, 'avg') // hack to get rid of svg style in <style> tag
          mermaidEl.innerHTML = svgGraph
          const svgEl = mermaidEl.firstElementChild
          d3.select(svgEl)
            .insert('rect', ':first-child')
            .attr('width', '100%')
            .attr('height', '100%')
            .attr('fill', 'white')
          d3.select(svgEl)
            .style('max-width', null)
            .style('font-size', '14px')
            .style('color', '#000')
            .attr('height', this.height + 'px')
        }
        mermaid.render('mm1', mermaidGraphDefinition, cb)
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
