<template>
  <div class="holder">
    <div class="header">
      Leo Viewer
      <div @click="toggle" class="icon" style="padding:0;margin:0">
        <icon class="icon bars" name="bars"></icon>
      </div>
      <div class="vshim"></div>
      <icon class="icon" name="arrow-right"></icon>
      <icon class="icon" name="arrow-left"></icon>
    </div>

    <div id="menu" class="menu">
      <div class="menu-header">View Type</div>
      <div class="menu-item"
           @click="setViewType('tree')">
        <div class="icon-box">
          <icon
            name="check"
            v-show="viewType === 'tree'"
            class="check"></icon>
        </div>
        <div class="menu-label">Outline</div>
      </div>
      <div class="menu-item"
           @click="setViewType('inline')">
        <div class="icon-box">
          <icon name="check"
                v-show="viewType === 'inline'"
                class="check"></icon>
        </div>
        <div class="menu-label">Inline</div>
      </div>
      <div class="menu-separator"></div>
    </div>

  </div>
</template>

<script>
  export default {
    name: 'appheader',
    data () {
      return {
        menu: false
      }
    },
    methods: {
      toggle () {
        console.log(this.menu)
        const menuEl = document.getElementById('menu')
        if (this.menu) {
          menuEl.style.width = 0
          menuEl.style.borderLeft = 'none'
        } else {
          menuEl.style.width = '160px'
          menuEl.style.borderLeft = '1px solid #ccc'
        }
        this.menu = !this.menu
      },
      setViewType (type) {
        this.$store.commit('VIEW_TYPE', {type: type})
        switch (type) {
          case 'tree':
            this.$router.replace({path: '/t/2', params: {id: 1}})
            break
          case 'inline':
            this.$router.replace({path: '/a/2', params: {id: 1}})
            break
        }
      }
    },
    computed: {
      viewType () {
        return this.$store.state.viewType
      }
    }
  }
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style lang="sass" scoped>
  .check
    margin-top: 2px
    margin-bottom: -3px
  .bars
    cursor: pointer
  .holder
    padding: 0
    margin: 0
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
    position: absolute
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
    border: 1px solid #ddd
    margin-top: 10px
  .header
    text-align: left
    background: #eee
    font-weight: normal
    padding: 2px
    padding-left: 6px
    color: #333
    border-bottom: 1px solid #ddd
  .icon
    float: right
    padding: 3px
    padding-right: 7px
    color: #333
  .vshim
    width: 8px
    float: right
</style>
