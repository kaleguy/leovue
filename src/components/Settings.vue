<template>
  <div class="settings">
    <div>
 <h1>Settings</h1>
      <div>Version 0.9.4</div>
    </div>
  </div>
</template>

<script>

  export default {
    name: 'settings',
    components: {
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
