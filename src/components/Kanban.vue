<template>
  <div>
    <h1>BAR</h1>
    <div
      class="col"
      v-for="col in item.children"
    >
      {{col.name}}
      <div
        v-for="card in col.children"
      >
        {{card.name}}
      </div>
    </div>
  </div>
</template>

<script>
  export default {
    name: 'kanban',
    components: {
    },
    methods: {
      main () {
      }
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
      data () {
        return this.$store.state.leodata
      },
      item () {
        const id = this.$store.state.currentItem.id
        return JSON.search(this.data, '//*[id="' + id + '"]')[0]
      }
    },
    mounted () {
    },
    watch: {
      '$route' (to, from) {
        // console.log(to, from)
      }
    }
  }
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style lang="sass" scoped>
.col
  border: 1px solid red
</style>
