<template>
  <div class="d3viewer">
   <h1>TEST</h1>
  </div>
</template>

<script>
  import D3Tree from 'vued3tree'

  console.log(D3Tree)

  let target = {el: null}
  export default {
    name: 'd3viewer',
    props: {
    },
    components: {
    },
    data: function () {
      return {
        target: target,
        open: false,
        active: false,
        lhandle: true
      }
    },
    watch: {
      '$route': {
        handler: function (val, oldVal, changed) {
        //  this.id = val.params.id
        },
        immediate: true
      }
    },
    computed: {
      data () {
        return this.$store.state.leodata
      },
      text () {
        return this.$store.state.leotext
      }
    },
    mounted: function () {
      this.$store.dispatch('loadLeo', {filename: 'docs'})
    }
  }
</script>
<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
  .accordionviewer{
    height: 100%
  }

  h1, h2 {
    font-weight: normal;
  }

  ul {
    list-style-type: none;
    padding: 0;
  }

  li {
    display: inline-block;
    margin: 0 10px;
  }

  a {
    color: #42b983;
  }

  .panes-container {
    display: flex;
    width: 100%;
    overflow: hidden;
  }

  .center-pane {
    width: 900px;
    background: #fff;
    margin-left:auto;
    margin-right:auto;
  }

  .panes-container {
    margin: 0;
    padding: 0;
    min-height: 100%;
  }
  p {
    line-height:1.3em;
  }

</style>
