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
      this.cols = ['firstName', 'lastName', 'instrument', 'birthday', 'songs']
      this.data = [
        { firstName: 'Joxxhn', lastName: 'Lennon', instrument: 'Guitar', birthday: '04/10/1940', songs: 72 },
        { firstName: 'Paul', lastName: 'McCartney', instrument: 'Bass', birthday: '18/06/1942', songs: 70 },
        { firstName: 'George', lastName: 'Harrison', instrument: 'Guitar', birthday: '25/02/1943', songs: 22 },
        { firstName: 'Ringo', lastName: 'Starr', instrument: 'Drums', birthday: '07/07/1940', songs: 2 }
      ]
    },
    mounted () {
      this.cols = ['firstName', 'lastName', 'instrument', 'birthday', 'songs']
      this.data = [
        { firstName: 'Joxxhn', lastName: 'Lennon', instrument: 'Guitar', birthday: '04/10/1940', songs: 72 },
        { firstName: 'Paul', lastName: 'McCartney', instrument: 'Bass', birthday: '18/06/1942', songs: 70 },
        { firstName: 'George', lastName: 'Harrison', instrument: 'Guitar', birthday: '25/02/1943', songs: 22 },
        { firstName: 'Ringo', lastName: 'Starr', instrument: 'Drums', birthday: '07/07/1940', songs: 2 }
      ]
      this.currentTable = this.dynComponent
    },
    computed: {
      id: function () {
      },
      fooComponent () {
        const template = `<h1>WATUP {{foo}}{{foox}}</h1>`
        return {
          template,
          props: {
            foo: 'XXXXX'
          },
          data () {
            return {
              foox: 'burk'
            }
          }
        }
      },
      dynComponent () {
        const d = this.data
        const template = `
            <table-component
              :data="data"
              sort-by="songs"
              sort-order="asc">
             <table-column show="firstName" label="First name"></table-column>
             <table-column show="lastName" label="Last name"></table-column>
             <table-column show="instrument" label="Instrument"></table-column>
             <table-column show="songs" label="Songs" data-type="numeric"></table-column>
             <table-column show="birthday" label="Birthday" data-type="date:DD/MM/YYYY"></table-column>
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
