<template>
  <div id="MathExample">
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
      console.log(2)
      MathJax.Hub.Queue(['Typeset', MathJax.Hub, this.$el])
    },
    updated () {
      console.log(1)
      // MathJax.Hub.Queue(['Typeset', MathJax.Hub, 'MathExample'])
    }
  }
</script>

//MathJax.Hub.Queue(["Typeset",MathJax.Hub,"MathExample"]);

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style lang="sass" scoped>
</style>
