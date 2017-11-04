<template>
  <div class="section-link" @click="gotoSection">« {{title}} »</div>
</template>

<script>
  export default {
    name: 'sectionlink',
    props: {
      title: String
    },
    data () {
      return {
      }
    },
    methods: {
      gotoSection: function () {
        console.log('hi')
      }
    },
    components: {}
  }
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style lang="sass" scoped>
.section-link
  color: blue
  cursor: pointer
  text-decoration: none
</style>
