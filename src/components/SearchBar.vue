<template>
  <div class="searchbar">
    <div id="app">
      <vue-instant :suggestion-attribute="suggestionAttribute"
                   v-model="value" :disabled="false"
                   @input="changed"
                   @click-input="clickInput"
                   @click-button="clickButton"
                   @selected="selected"
                   @enter="enter"
                   @key-up="keyUp"
                   @key-down="keyDown"
                   @key-right="keyRight"
                   @clear="clear"
                   @escape="escape"
                   :show-autocomplete="true"
                   :autofocus="false"
                   :suggestions="suggestions"
                   name="customName"
                   placeholder=""
                   type="twitter"></vue-instant>
    </div>
  </div>
</template>

<script>
  // import axios from 'axios'
  import _ from 'lodash'
  import VueInstant from './VueInstant'
  export default {
    name: 'searchbar',
    data () {
      return {
        value: '',
        suggestionAttribute: 'title',
        suggestions: [],
        selectedEvent: ''
      }
    },
    methods: {
      clickInput: function () {
        this.selectedEvent = 'click input'
      },
      clickButton: function () {
        this.selectedEvent = 'click button'
      },
      selected: function () {
        this.selectedEvent = 'selection changed'
      },
      enter: function () {
        this.selectedEvent = 'enter'
      },
      keyUp: function () {
        this.selectedEvent = 'keyup pressed'
      },
      keyDown: function () {
        this.selectedEvent = 'keyDown pressed'
      },
      keyRight: function () {
        this.selectedEvent = 'keyRight pressed'
      },
      clear: function () {
        this.selectedEvent = 'clear input'
      },
      escape: function () {
        this.selectedEvent = 'escape'
      },
      changed: function () {
        this.suggestions = []
        var that = this
        if (this.value.length < 2) { return }
        const state = this.$store.state
        const items = state.idx.search(this.value)
        items.forEach(item => {
          let doc = _.find(state.idxDocs, d => d.id === item.ref)
          that.suggestions.push(
            {
              title: doc.name,
              text: doc.text,
              id: doc.id
            })
        })
        /*
        axios.get('https://api.themoviedb.org/3/search/movie?api_key=342d3061b70d2747a1e159ae9a7e9a36&query=' + this.value)
          .then(function (response) {
            console.log('R', response.data.results)
            response.data.results.forEach(function (a) {
              that.suggestions.push(a)
            })
          })
        */
      }
    },
    components: {
      'vue-instant': VueInstant
    }
  }
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style lang="sass">
.settings
  padding: 40px
.sbx-twitter__input
   box-shadow: none
.sbx-twitter__input-placeholder
  box-shadow: none
  // background: #fff
</style>
