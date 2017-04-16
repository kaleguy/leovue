<template>
  <div class="dashboard">
    <appheader/>
    <div id="main">
      <router-view :id="$route.params.id"></router-view>
    </div>
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
#main {
  padding-top: 20px;
  height: 100%;
}
a {
  color: #42b983;
}
.dashboard{
  height: 100%;
}
</style>
