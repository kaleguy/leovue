<template>
  <div :style="style">
    <svg xmlns="http://www.w3.org/2000/svg"
         xmlns:xlink="http://www.w3.org/1999/xlink"
         :viewBox="viewBox"
         version="1.1">
    <slot></slot>
    </svg>
  </div>
</template>

<script>
  export default {
    name: 'v-svg',
    components: {
    },
    props: {
      viewBox: {
        type: String,
        default: '0, 0, 900, 900'
      },
      height: {
        type: String,
        default: '400'
      }
    },
    data () {
      return {
      }
    },
    mounted () {
    },
    computed: {
      id: function () {
      },
      style: function () {
        const height = this.height || '400'
        return 'height:' + height + 'px'
      }
    }
  }
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style lang="sass">

</style>
