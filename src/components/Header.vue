<template>
  <div class="Header">
  Leo Viewer
    <icon class="icon" name="bars"></icon>
    <div class="vshim"></div>
    <icon class="icon" name="arrow-right"></icon>
    <icon class="icon" name="arrow-left"></icon>
  </div>
</template>

<script>
  export default {
    name: 'appheader',
    data () {
      return {
      }
    }
  }
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
  DIV {
    text-align: left;
    background: #eee;
    font-weight: normal;
    padding:2px;
    padding-left:6px;
    color: #333;
    border-bottom: 1px solid #ddd;
  }
  .icon {
    float: right;
    padding:3px;
    padding-right: 7px;
    color: #333;
  }
  .vshim {
    width: 8px;
    float: right;
  }
</style>
