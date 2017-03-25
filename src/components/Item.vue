<template>
  <li>
    <div
      :class="{bold: isFolder, active: active}"
      @click="toggle">
      <span v-if="isFolder">{{open ? '▼' : '▶'}}</span>
      {{model.name}}
    </div>
    <ul v-show="open" v-if="isFolder">
      <item
        class="item"
        v-for="model in model.children"
        :model="model">
      </item>
    </ul>
  </li>
</template>

<script>
let currentNode = null
export default {
  name: 'item',
  props: {
    model: Object
  },
  data: function () {
    return {
      open: false,
      active: false
    }
  },
  computed: {
    isFolder: function () {
      return this.model.children && this.model.children.length
    }
  },
  methods: {
    toggle: function () {
      if (this.isFolder) {
        this.open = !this.open
      }
      if (currentNode) {
        currentNode.active = false
      }
      currentNode = this
      currentNode.active = true

      console.log(this)
      // showText(this.model.text)
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
  
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

</style>
