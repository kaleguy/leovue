<template>
  <div class="accordionviewer">
    <div class="panes-container">
      <div class="center-pane" id="center-pane">
        <ul id="demo">
          <item
            class="item"
            :top="true"
            :showContentFlag="true"
            :model="data"
            :textItems="text"
            :open="false">
          </item>
        </ul>
      </div>
    </div>
  </div>
</template>

<script>
  import Item from './Item'

  let target = {el: null}
  export default {
    name: 'accordionviewer',
    props: {
    },
    components: {
      item: Item
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
