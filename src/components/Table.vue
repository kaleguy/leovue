<template>
  <div style="margin-right:8px">
   <table>
     <caption>{{caption}}</caption>
     <thead>
       <th v-for="(cell, c) in firstRow" v-if="dataCol(c)">{{ cell }}</th>
     </thead>
     <tbody>
       <tr v-for="(row, r) in table" v-if="r">
          <td v-for="(cell, c) in row" v-if="dataCol(c)">{{ cell }}</td>
       </tr>
     </tbody>
   </table>
  </div>
</template>

<script>
export default {
  name: 'vtable',
  props: {
    dataTable: String,
    hideTitle: Boolean
  },
  components: {
  },
  methods: {
    main () {
      this.$router.replace({path: '/'})
    },
    dataCol (index) {
      if (this.firstRow[index].indexOf('$') > -1) {
        return false
      }
      return true
    }
  },
  data () {
    return {
      table: Object,
      caption: String
    }
  },
  computed: {
    id: function () {
    },
    firstRow: function () {
      return this.table[0]
    }
  },
  mounted () {
    const tableObj = this.$store.state.dataTables[this.dataTable]
    if (tableObj) {
      this.table = tableObj.arr
      if (!this.hideTitle) { this.caption = tableObj.title }
    } else {
      this.table = [[]]
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
<style lang="sass" scoped>
TABLE
  border: 1px solid #ccc
  padding: 4px
  width: 100%
  box-shadow: 1px 1px 7px #ccc
  padding-right: 8px
CAPTION
  font-weight: bold
TH
  font-size: 13px
  text-align: right
  padding-left: 8px
TD
  font-size: 13px
  text-align: right
  padding: 0
  padding-left: 4px
  white-space: nowrap
TR TD:first-child
  font-weight: bold
</style>
