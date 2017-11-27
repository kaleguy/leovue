<template>
  <div>
    <div class="mermaid"><slot></slot></div>
  </div>
</template>

<script>
  export default {
    name: 'vctable',
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
      const mermaidEl = document.getElementsByClassName('mermaid')[0]
      mermaidEl.style.height = this.height + 'px'
      mermaidEl.style.width = this.width + 'px'
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
  margin-left: auto
  margin-right: auto
</style>
