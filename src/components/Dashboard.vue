<template>
  <div class="dashboard">
    <appheader/>
    <treeviewer :id="$route.params.id"></treeviewer>
  </div>
</template>

<script>
import TreeViewer from './TreeViewer'
import AppHeader from './Header'

export default {
  name: 'dashboard',
  components: {
    treeviewer: TreeViewer,
    appheader: AppHeader
  },
  data () {
    return {
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
<style scoped>
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
.dashboard{
  height: 100%;
}
</style>
