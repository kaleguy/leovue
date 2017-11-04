<template>
  <div class="section-link" @click="gotoSection">« {{title}} »</div>
</template>

<script>
  import _ from 'lodash'
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
        const searchTitle = '« ' + _.trim(this.title) + ' »'
        const titleObj = JSON.search(this.$store.state.leodata, '//*[name="' + searchTitle + '"]')[0]
        let id = null
        if (titleObj) {
          id = titleObj.id
          this.$store.dispatch('setCurrentItem', {id})
        }
      }
    },
    components: {}
  }
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style lang="sass" scoped>
.section-link
  color: #4cb986
  font-weight: bold
  cursor: pointer
  text-decoration: none
</style>
