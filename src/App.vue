<template>
  <div id="app">
    <router-view></router-view>
  </div>
</template>

<script>
export default {
  name: 'app'
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  color: #2c3e50;
  margin: 0;
  padding: 0;
  height: 100%;
}
HTML, BODY {
  margin: 0;
  padding: 0;
  height: 100%;
  width: 100%;
}
.right-pane .text {
  margin-top:20px;
  border: none;
  background-color: transparent;
  resize: none;
  outline: none;
  font-size:16px;
  height:100%;
  white-space: pre-line;
  width:100%;
}
.directive {
  color: #990000;
}
</style>
