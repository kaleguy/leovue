<template>
  <div>
    <div class="img" style="float:left"><img :height="heightpx" :src="src" /></div>
    <div class="txt"><slot name="txt" /></div>
    <div class="footer" style="clear:both; text-align:center; padding-top:30px"><slot name="foot"/></div>
  </div>
</template>

<script>
  export default {
    name: 'imgLeft',
    props: {
      src: String,
      height: String
    },
    computed: {
      heightpx: function () {
        if (!this.height) { this.height = '300' }
        return this.height + 'px'
      }
    }
  }
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<!-- No styles here because won't work when embedded in presentation -->
<style lang="sass" scoped>

</style>
