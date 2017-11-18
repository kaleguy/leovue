<template>
  <div>
    <component :is="currentTable"/>
  </div>
</template>

<script>
  export default {
    name: 'vctable',
    components: {
    },
    props: {
      dataTable: String
    },
    methods: {
    },
    data () {
      return {
        data: [],
        cols: [],
        currentTable: null
      }
    },
    beforeCreate () {
    },
    mounted () {
      const tableObj = this.$store.state.dataTables[this.dataTable]
      if (tableObj) {
        this.data = tableObj.objArr
        this.cols = tableObj.arr[0]
      } else {
      }

      /*
      this.cols = ['firstName', 'lastName', 'instrument', 'birthday', 'songs']
      this.data = [
        { firstName: 'Joxxhn', lastName: 'Lennon', instrument: 'Guitar', birthday: '04/10/1940', songs: 72 },
        { firstName: 'Paul', lastName: 'McCartney', instrument: 'Bass', birthday: '18/06/1942', songs: 70 },
        { firstName: 'George', lastName: 'Harrison', instrument: 'Guitar', birthday: '25/02/1943', songs: 22 },
        { firstName: 'Ringo', lastName: 'Starr', instrument: 'Drums', birthday: '07/07/1940', songs: 2 }
      ]
      */
      this.currentTable = this.dynComponent
    },
    computed: {
      id: function () {
      },
      dynComponent () {
        const d = this.data
        let cols = ''
        this.cols.forEach(c => {
          cols = cols + `<table-column show="${c}" label="${c}"></table-column>`
        })
        debugger
        const template = `
            <table-component
              :data="data"
              sort-by="songs"
              sort-order="asc">
              ${cols}
            </table-component>
        `
        return {
          template, // use content as template for this component
          data () {
            return {
              data: d
            }
          }
        }
      }
    }
  }
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style lang="sass" scoped>
</style>
