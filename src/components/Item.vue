<template>
  <li :x-id="model.id">
    <div
      :class="{bold: isFolder, active: active, topItem: top}"
      @click="toggle">
      <div v-bind:class="{'icon-bracket': top}"
           style="display:inline-block;
           padding-left:3px;
           padding-right:3px;"
           v-if="isFolder">
        <div class="arrow"
             v-bind:class="{arrowdown: isOpenA}">▶</div>
      </div>
      <span class="otitle">{{vtitle}}</span>
    </div>
    <div v-show="isOpen" class="child-items">
      <div v-show="isOpenInline"
           :id="'item-' + model.id"
           v-html="myContent"
           class="inline">
      </div>
      <ul v-if="isFolder">
        <item
          class="item"
          v-for="model in model.children"
          :model="model"
          :key="model.id"
          :textItems="textItems"
          :targetEl="targetEl">
        </item>
        <div v-show="isOpenInline" class="hshim"></div>
      </ul>
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
    top: Boolean
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
      return this.model.children && this.model.children.length
    },
    isOpen: function () {
      const ids = this.$store.state.openItemIds
      let open = true
      if (ids.indexOf(this.model.id) === -1) { open = false }
      return open
    },
    isOpenInline: function () {
      return this.isOpen && this.$route.name === 'ANode'
    },
    isOpenA: function () {
      return this.isOpen && !this.closearrow
    },
    active: function () {
      // TODO: change ids to strings
      if (!this.model) { return }
      return +this.$store.state.currentItem.id === +this.model.id
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
    inlineClass: function () {
      return 'inline'
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
      let inline = true
      if (this.targetEl) {
        inline = false
      }
      this.inline = inline
      if (this.isFolder) {
        const ul = this.$el.getElementsByClassName('child-items')[0]
        const il = this.$el.getElementsByClassName('inline')[0]
        ul.style.display = 'block'
        if (inline) {
          il.style.display = 'block'
        }
        if (!this.isOpen) {
          this.$store.commit('OPEN_ITEMS', {openItemIds})
          Velocity(ul, 'slideDown', {duration, easing}).then(els => {
          })
        } else {
          Velocity(ul, 'slideUp', {duration, easing}).then(els => {
            this.$store.commit('OPEN_ITEMS', {openItemIds})
            this.closearrow = false
          })
        }
      }
      // toggle inline content if in inline mode
      if (inline && !this.isFolder) {
        duration = 300
        // TODO: refactor this
        let il = this.$el.getElementsByClassName('inline')[0]
        // if (!il) {
        //   il = this.$el.getElementsByClassName('vinline')[0]
        // }
        il.parentElement.style.display = 'block'
        if (!this.isOpen) {
          this.$store.commit('OPEN_ITEMS', {openItemIds})
          Velocity(il, 'slideDown', {duration, easing}).then(els => {
          })
        } else {
          Velocity(il, 'slideUp', {duration, easing}).then(els => {
            this.$store.commit('OPEN_ITEMS', {openItemIds})
            this.closearrow = false
          })
        }
      }
      const id = this.model.id
      this.$store.dispatch('setCurrentItem', {id})
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
ul
  padding-left: 1em
  line-height: 1.4em
  list-style-type: none
  margin-bottom: 8px
li
  white-space: nowrap
  min-width: 760px
  margin-bottom: 4px
  margin-top: 4px
li > div
  padding-left: 4px
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
  margin-top: 4px
  margin-bottom: 16px
  border: 1px solid $contentBorderColor
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
</style>
