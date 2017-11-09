<template>
  <div style="display:none">
    $$<slot></slot>$$
  </div>
</template>

<script>
  export default {
    name: 'mathjax',
    data () {
      return {
      }
    },
    methods: {
    },
    components: {},
    mounted () {
      if (MathJax) {
        MathJax.Hub.Queue(['Typeset', MathJax.Hub, this.$el])
        MathJax.Hub.Queue(() => this.$el.style.display = 'block')
      }
    },
    updated () {
    }
  }
</script>

//MathJax.Hub.Queue(["Typeset",MathJax.Hub,"MathExample"]);

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style lang="sass" scoped>
</style>
