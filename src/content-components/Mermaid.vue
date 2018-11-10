<template>
    <div :name="name" class="mermaid">
      <slot></slot>
    </div>
 </template>

<script>
  /* global mermaid */
  export default {
    name: 'mermaid',
    components: {
    },
    props: {
      name: {
        type: String,
        default: 'mm'
      },
      height: {
        type: String,
        default: '100%'
      },
      width: {
        type: String,
        default: ''
      },
      mm: {
        type: String,
        default: ''
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
    updated () {
      const mermaidEl = this.$el
      mermaidEl.style.height = this.height + 'px'
      mermaidEl.style.width = this.width + 'px'
      mermaidEl.name = this.name
      if (this.mm) {
        mermaidEl.innerHTML = this.mm
      }
      mermaidEl.removeAttribute('data-processed')
      mermaid.init(undefined, mermaidEl) // eslint-disable-line
    },
    mounted () {
      const mermaidEl = this.$el
      mermaidEl.style.height = '90%'
      // mermaidEl.style.width = this.width + 'px'
      // mermaidEl.style.height = this.height + 'px'
      // mermaidEl.style.width = this.width + 'px'
      mermaidEl.name = this.name
      const config = {
        startOnLoad: true,
        flowchart: {
          useMaxWidth: true,
          htmlLabels: true
        },
        theme: 'forest'
      }
      mermaid.initialize(config)
      mermaidEl.removeAttribute('data-processed')
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
  // margin-top: 60px
  text-align: center
  // margin-left: auto
  // margin-right: auto
</style>
