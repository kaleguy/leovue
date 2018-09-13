<template>
  <div class="dashboard">
    <appheader/>
    <div id="main" :class="{'header-space': config.showHeader}">
      <router-view :id="id"></router-view>
    </div>
  </div>
</template>

<script>
import AppHeader from './Header'

export default {
  name: 'dashboard',
  components: {
    appheader: AppHeader
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
    },
    config () {
      return window.lconfig
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
  height: calc(100vh - 33px);
  position: relative;
}
a {
  color: #42b983;
}
.dashboard{
  height: 100%;
}
</style>
