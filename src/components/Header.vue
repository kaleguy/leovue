<template>
  <div style="height:33px">
    <div class="holder">
      <div class="header" v-if="config.showHeader">
        <span v-if="config.showAppTitle" class="app-title">Leo Vue</span>
        <span v-if="config.showAppTitle && config.docTitle">: </span>
        <span class="doc-title">{{ config.docTitle }}</span>
        <div @click="toggle" class="icon icon-button">
          <icon class="icon" name="bars"></icon>
        </div>
        <div class="button-shim"></div>
        <div @click="goForward"
             class="icon icon-button">
          <icon class="icon"
                :class="{disabled: noForward}"
                name="arrow-right"></icon>
        </div>
        <div @click="goBack"
             class="icon icon-button disabled">
          <icon class="icon"
                :class="{disabled: noBack}"
                name="arrow-left"></icon>
        </div>
        <div class="hshim"></div>
        <searchbar class="searchbar"></searchbar>
        <div class="vshim"></div>
      </div>
    </div>
    <div id="menu" class="menu">
      <div class="menu-header">View Type</div>
      <div  v-for="v in viewTypes"
            class="menu-item"
            @click="setViewType(v.type)">
        <div class="icon-box">
          <icon
            name="check"
            v-show="viewType === v.type"
            class="check"></icon>
        </div>
        <div class="menu-label">{{v.name}}</div>
      </div>
      <div class="menu-separator"></div>
      <div class="hshim"></div>
      <div @click="setAccordion()"
           class="menu-item">
        <div class="icon-box">
          <icon
            name="check"
            v-show="accordion"
            class="check"></icon>
        </div>
        <div class="menu-label">Accordion</div>
      </div>
      <div class="menu-footer" @click="settings">Leo Vue</div>
    </div>
  </div>
</template>

<script>
  import SearchBar from './SearchBar'
  export default {
    name: 'appheader',
    components: {
      searchbar: SearchBar
    },
    data () {
      return {
        menu: false
      }
    },
    methods: {
      settings () {
        this.$router.replace({path: '/settings'})
      },
      setAccordion () {
        this.$store.commit('TOGGLEACCORDION')
      },
      toggle () {
        const menuEl = document.getElementById('menu')
        if (this.menu) {
          menuEl.style.width = 0
          menuEl.style.borderLeft = 'none'
        } else {
          menuEl.style.width = '180px'
          menuEl.style.borderLeft = '1px solid #ccc'
        }
        this.menu = !this.menu
      },
      setViewType (type) {
        this.$store.commit('VIEW_TYPE', {type})
        this.$store.commit('RESET')
        this.$router.replace({path: '/' + type + '/' + this.$store.state.currentItem.id})
        // close the menu
        setTimeout(this.toggle, 500)
      },
      goBack () {
        if (this.noBack) { return }
        const history = this.$store.state.history
        let historyIndex = this.$store.state.historyIndex
        if (historyIndex > 0) {
          historyIndex = historyIndex - 1
        }
        const id = history[historyIndex]
        this.$store.commit('CURRENT_ITEM', { id, historyIndex })
      },
      goForward () {
        if (this.noForward) { return }
        const history = this.$store.state.history
        let historyIndex = this.$store.state.historyIndex
        const id = history[historyIndex + 1]
        if (historyIndex < history.length - 1) {
          historyIndex = historyIndex + 1
        }
        this.$store.commit('CURRENT_ITEM', { id, historyIndex })
      }
    },
    computed: {
      viewType () {
        return this.$store.state.viewType
      },
      accordion () {
        return this.$store.state.accordion
      },
      viewTypes () {
        let viewTypes = [
          {name: 'Outline', type: 't'},
          {name: 'Inline', type: 'a'},
          {name: 'Graphic Tree', type: 'd'},
          {name: 'Dendrogram', type: 'z'},
          {name: 'Nested Menu', type: 'n'},
          {name: 'Movable Panes', type: 'w'}
        ]
        if (this.config.viewTypes) {
          return this.config.viewTypes
        }
        return viewTypes
      },
      noBack () {
        return this.$store.state.historyIndex < 2
      },
      noForward () {
        return this.$store.state.historyIndex >= this.$store.state.history.length - 1
      },
      config () {
        return window.lconfig
      }

    }
  }
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style lang="sass" scoped>
.check
  margin-top: 2px
  margin-bottom: -3px
.holder
  padding: 0
  margin: 0
  position: fixed
  width: 100%
  z-index: 111
.icon-box
  width: 20px
  margin-left: 20px
  display: inline-block
.menu-label
  width: 80px
  display: inline
.menu-header
  padding: 10px
  font-weight: bold
  text-align: center
  white-space: nowrap
.menu-item
  padding: 4px
  // text-align: center
  white-space: nowrap
  cursor: pointer
.menu
  position: fixed
  z-index: 111
  top: 33px
  overflow: hidden
  background: #ccc
  width: 0
  right: 0
  height: 100%
  //border-left: 1px solid #999
  border-top: 1px solid #ccc
  //-webkit-box-shadow: 10px 0 5px -2px #888;
  //box-shadow: 10px 0 5px -2px #888;
  //box-shadow: -4px 0 8px -4px rgba(31, 31, 31, 0.8)
  transition: width .5s
.menu-separator
  border-bottom: 1px solid #ddd
  margin-top: 10px
.header
  text-align: left
  background: #eee
  font-weight: normal
  padding: 2px
  padding-top: 6px
  padding-left: 6px
  color: #333
  border-bottom: 1px solid #ddd
  height: 24px
.search
  float: right
  font-family: Avenir, Nunito, Helvetica, Arial, sans-serif
  margin-right: 10px
  font-size: 14px
  margin-top: -1px
  display: none
.icon
  float: right
  padding: 0
  padding-top: 2px
  padding-right: 7px
  color: #666
.icon-button
  cursor: pointer
  margin: 0
  padding: 0
.vshim
  width: 8px
  float: right
.disabled
  color: #ccc
.button-shim
  width: 8px
  float: right
  height: 16px
.app-title
  font-weight: normal
  color: #333
.doc-title
  font-weight: bold
.menu-footer
  color: #fff
  position: absolute
  bottom: 60px
  width: 100%
  text-align: center
  text-decoration: none
  cursor: pointer
.searchbar
  position: absolute
  right: 80px
  top: 0
</style>
