<template>
  <li :id="model.id" v-bind:class="{'unselected-sibling': hasOpenSibling}">
    <div class="item-box"
         :class="{bold: isFolder, active: active, topItem: top}">
      <div
        @click="toggle">
        <div v-bind:class="{'icon-bracket': top}"
             style="display:inline-block;
             padding-left:3px;
             padding-right:3px;"
             v-if="isFolder">
          <div class="arrow"
               v-bind:class="{arrowdown: isOpenA}">▶</div>
        </div>
        <div class="leo-box"></div>
        <div v-if="!isFolder" class="leaf-button"></div>
        <span class="otitle">{{vtitle}}</span>
      </div>
    </div>
    <div v-show="isOpen" class="child-items">
      <div v-html="myContent"
           class="inline">
      </div>
      <ul v-if="isFolder">
        <item
          class="item"
          v-for="model in model.children"
          :model="model"
          :key="model.id"
          :textItems="textItems"
          :accordion="accordion"
          :targetEl="targetEl">
        </item>
      </ul>
      <div v-show="isOpenInline" class="hshim"></div>
    </div>
  </li>
</template>

<script>

import Velocity from 'velocity-animate'
export default {
  name: 'item',
  props: {
    model: Object,
    targetEl: Boolean,
    textItems: Object,
    top: Boolean,
    accordion: Boolean
  },
  data: function () {
    return {
      reset: true,
      openFlag: false,
      inline: false,
      closearrow: false,
      myContent: ''
    }
  },
  computed: {
    isFolder: function () {
      if (/\.leo\)$/.test(this.model.name)) { return true } // subtree
      return this.model.children && this.model.children.length
    },
    isClosedSibling: function () {
      if (this.isOpen) { return ' open' }
      const nextSiblings = JSON.search(this.$store.state.leodata, '//*[id="' + this.model.id + '"]/following-sibling::*')
      const prevSiblings = JSON.search(this.$store.state.leodata, '//*[id="' + this.model.id + '"]/preceding-sibling::children')
      var foo = nextSiblings.length + '_' + prevSiblings.length
      return foo
      // check if any siblings are open
      // if yes then return true
      // else return false
    },
    hasOpenSibling: function () {
      if (!this.accordion) { return false }
      // TODO: this is slow, need to refactor, possibly replace defiant wth parent pointer on item
      // if (this.isOpen) { return ' open' }
      if (!this.isOpen) { return }
      console.log('sibling')
      const nextSiblings = JSON.search(this.$store.state.leodata, '//*[id="' + this.model.id + '"]/following-sibling::*')
      const prevSiblings = JSON.search(this.$store.state.leodata, '//*[id="' + this.model.id + '"]/preceding-sibling::children')
      let siblings = nextSiblings.concat(prevSiblings)
      siblings = siblings.map(s => s.id)
      let hasOpen = false
      const ids = this.$store.state.openItemIds
      siblings.forEach(sid => {
        if (ids.indexOf(sid + '') > -1) { hasOpen = true }
      })
      hasOpen = false
      return hasOpen
      // check if any siblings are open
      // if yes then return true
      // else return false
    },
    isOpen: function () {
      const ids = this.$store.state.openItemIds
      let open = true
      if (ids.indexOf(this.model.id + '') === -1) { open = false }
      return open
    },
    isOpenInline: function () {
      return this.$route.name === 'ANode'
      // return true
      // return this.isOpen && this.$route.name === 'ANode'
    },
    isOpenA: function () {
      return this.isOpen && !this.closearrow
    },
    active: function () {
      // TODO: change ids to strings
      if (!this.model) { return }
      return this.$store.state.currentItem.id === this.model.id
    },
    vtitle: function () {
      const re = /^\[(.*?)\]\((.*?)\)$/
      const match = re.exec(this.model.name)
      if (!match) {
        return this.model.name
      }
      const title = match[1]
      if (title) {
        return title
      } else {
        return this.name
      }
    },
    initialized () {
      return this.$store.state.initialized
    }
  },
  methods: {
    toggle: function () {
      // toggle the tree node
      let duration = 300
      const easing = 'linear'
      this.reset = false // TODO: remove
      // toggle the open/close state of the item
      let openItemIds = this.$store.state.openItemIds.slice(0)
      if (!this.isOpen) {
        openItemIds.push(this.model.id)
      } else {
        openItemIds = openItemIds.filter(id => id !== this.model.id)
        this.closearrow = true
      }
      const ul = this.$el.getElementsByClassName('child-items')[0]
      if (!this.isOpen) {
        this.$store.commit('OPEN_ITEMS', {openItemIds})
        Velocity(ul, 'slideDown', {duration, easing}).then(els => {
          if (this.accordion) {
            this.closeSiblings(easing, 'Up')
          }
        })
      } else {
        Velocity(ul, 'slideUp', {duration, easing}).then(els => {
          this.$store.commit('OPEN_ITEMS', {openItemIds})
          this.closearrow = false
          if (this.accordion) {
            this.closeSiblings(easing, 'Down')
          }
        })
      }
      const id = this.model.id
      this.$store.dispatch('setCurrentItem', {id})
      // close siblings if in accordion mode
    },
    closeSiblings: function (easing, direction) {
      const duration = 500
      const nextSiblings = JSON.search(this.$store.state.leodata, '//*[id="' + this.model.id + '"]/following-sibling::*')
      const prevSiblings = JSON.search(this.$store.state.leodata, '//*[id="' + this.model.id + '"]/preceding-sibling::children')
      let siblings = nextSiblings.concat(prevSiblings)
      siblings = siblings.map(s => s.id)
      siblings.forEach(sid => {
        let el = document.getElementById(sid)
        Velocity(el, 'slide' + direction, {duration, easing}).then(els => {
        })
      })
    }
  },
  watch: {
    '$store.state.contentItemsUpdateCount': {
      handler: function (val, oldVal) {
        if (!this.isOpenInline) { return }
        if (val > 0 && val !== oldVal) {
          const text = this.$store.state.contentItems[this.model.id]
          // if (!text) { return }
          this.myContent = text
        }
      },
      deep: true,
      immediate: true
    }
  },
  mounted () {
  },
  updated () {
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style lang="sass">
$contentBorderColor: #ccc
.topItem
  margin-bottom: 10px
  SPAN
    font-size: 30px
    line-height: 1.5
.topItemIcon
  vertical-align: top
  padding-left: 20px
  margin-right: -10px
.icon-bracket
  display:inline-block
  height: 100%
  vertical-align: middle
  padding-bottom: 8px
  padding-left: 0
  .arrow
    display:inline-block
    height: 100%
    vertical-align: middle
    padding-bottom: 2px
    width: 20px
.arrow
  -webkit-transition: all .1s ease
  transition: all .1s ease
  text-align: center
  display: inline-block
  width: 11px
  height: 21px
  margin-top: 2px
.arrowdown
  -webkit-transform: rotate(90deg)
  transform: rotate(90deg)
.item
  cursor: pointer
  width: 100%
.bold
  font-weight: bold
.active
  background: #81ff00
  max-width: 762px
.activeb
  background: #81ff00
  font-weight: bold
.inline .content
  max-width: 700px
  white-space: normal
  padding: 30px
  padding-top: 20px
  padding-bottom: 20px
  //margin-top: 4px
  margin-bottom: 16px
  border: 6px solid $contentBorderColor
  border-radius: 4px
  // box-shadow: -4px 0 8px -4px rgba(31, 31, 31, 0.8)
.vinline
  max-width: 700px
  white-space: normal
  padding: 0
  padding-top: 0
  padding-bottom: 0
  margin-top: 4px
  margin-bottom: 16px
  height: 600px
  width: 760px
  border: 1px solid $contentBorderColor
  border-radius: 4px
  overflow: auto
// box-shadow: -4px 0 8px -4px rgba(31, 31, 31, 0.8)
.hshim
  height: 15px
.otitle
  padding-left: 4px
.child-items
  margin: 0
  padding: 0
.unselected-sibling
  background-color: yellow
  height: 0
  overflow: hidden
  -webkit-transition: height 4s ease
  transition: height 4s ease
.leo-box
  display: none
</style>
