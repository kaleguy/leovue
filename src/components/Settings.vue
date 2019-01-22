<template>
  <div class="settings">
    <div>
      <h1 style="margin-left:0">LeoVue</h1>
      <div>Version 1.21.0</div>
      <div class="hshim"></div>
      <div><a href="https://github.com/kaleguy/leoviewer">LeoVue on Github</a></div>
      <div class="hshim"></div>
      <div v-if="staticSite">
        <div><a href="static/site/index.html">HTML Site</a></div>
      </div>
      <div class="hshim"></div>
      <div>
        <div class="link" @click="main">Return to Main</div>
      </div>
    </div>
  </div>
</template>

<script>
  export default {
    name: 'settings',
    components: {
    },
    methods: {
      main () {
        this.$router.replace({path: '/'})
      }
    },
    data () {
      return {
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
      staticSite: function () {
        if (window.lconfig.staticSite) {
          return true
        }
        return false
      }
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
  .settings
    padding: 40px
</style>
