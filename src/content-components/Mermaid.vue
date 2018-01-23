<template>
    <div class="mermaid"><slot></slot></div>
</template>

<script>
  /* global mermaid */
  export default {
    name: 'mermaid',
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
      const mermaidEl = this.$el
      mermaidEl.style.height = this.height + 'px'
      mermaidEl.style.width = this.width + 'px'
      const config = {
        startOnLoad: true,
        flowchart: {
          useMaxWidth: true,
          htmlLabels: true
          // width: '200%'
        },
        theme: 'forest'
      }
      mermaid.initialize(config)
      mermaid.init(undefined, mermaidEl) // eslint-disable-line
    },
    computed: {
      id: function () {
      }
    }
  }
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style lang="sass" scoped>
.mermaid
  text-align: center
  // margin-left: auto
  // margin-right: auto
</style>
