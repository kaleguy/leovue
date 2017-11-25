<template>
  <div :style="style">
    <svg xmlns="http://www.w3.org/2000/svg"
         xmlns:xlink="http://www.w3.org/1999/xlink"
         :viewBox="viewBox"
         version="1.1"
         style="height: 100%"
      >
      <rect width="100%" height="100%" fill="white" />
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
      },
      width: {
        type: String,
        default: '800'
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
        const height = this.height
        const width = this.width
        return `height:${height}px; max-width:${width}px; background: #fff; margin-left:auto; margin-right: auto;`
      }
    }
  }
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style lang="sass">

</style>
