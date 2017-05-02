<template>
  <div class="pane">
    <div v-show="textContent"
         id="tlayout">
      <div id="lhandle"
           class="handle">
        <div class="handle-button"
             v-show="hasPrev"
             @click="goPrev">
          <icon class="icon"
                name="chevron-left"></icon>
        </div>
      </div>
      <div class="right-cpane"
           v-html="currentItemContent">
      </div>
      <div id="rhandle"
           class="handle">
        <div class="handle-button"
             v-show="hasNext"
             @click="goNext">
          <icon class="icon"
                name="chevron-right"></icon>
        </div>
      </div>
    </div>
    <div v-show="iframeContent"
         style="min-height:100%; display:flex; background:#fff; width: 100%"
         v-html="iframeHTML"
         id="vpane">
    </div>
  </div>
</template>

<script>
import router from '../router'

export default {
  name: 'contentpane',
  components: {
  },
  data () {
    return {
    }
  },
  methods: {
    goNext () {
      const next = this.$store.state.currentItem.next
      this.resetCurrentItem(next)
    },
    goPrev () {
      const prev = this.$store.state.currentItem.prev
      this.resetCurrentItem(prev)
    },
    resetCurrentItem (id) {
      router.replace('/t/' + id)
      const currentItem = { id }
      this.$store.commit('RESET')
      this.$store.commit('CURRENT_ITEM', currentItem)
    }
  },
  computed: {
    data () {
      return this.$store.state.leodata
    },
    text () {
      return this.$store.state.leotext
    },
    iframeContent () {
      if (this.$store.state.contentPane === 'site') {
        return true
      } else {
        return false
      }
    },
    textContent () {
      if (this.$store.state.contentPane === 'text') {
        return true
      } else {
        return false
      }
    },
    currentItemContent () {
      // console.log('xxxx', this.$store.state.currentItemContent)
      return this.$store.state.currentItemContent
    },
    iframeHTML () {
      if (this.iframeContent) {
        return this.$store.state.iframeHTML
      } else {
        return ''
      }
    },
    hasNext () {
      return this.$store.state.currentItem.next
    },
    hasPrev () {
      return this.$store.state.currentItem.prev
    }
  },
  watch: {
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style>
  .handle-button {
    height:20px;
    width: 20px;
    margin-left: auto;
    margin-right: auto;
    cursor: pointer;
    text-align: center;
    position: fixed;
    top: 50%;
    transform: translateY(-50%);
    color: #ccf;
    margin-left: 9px;
  }
  #lhandle {
    max-width: 50px;
  }
  .handle {
    width:50px;
    align-items: center;
    flex: auto;
    display: flex;
  }
  .right-cpane {
    flex: auto;
    background: #fff;
    padding:0px;
    padding-top: 10px;
    max-width: 600px;
    min-width: 500px;
    height: calc(100vh - 26px);
    overflow: auto;
  }
  p {
    line-height:1.3em;
  }
  #vpane {
    width: 100%;
    background: #fff;
    height: 100%;
  }
  #tlayout {
    background: #fff;
    min-height: 100%;
    margin: 0;
    padding: 0;
    display: flex;
    flex-wrap: nowrap;
  }
  .pane {
    height: 100%;
    background: #fff;
    width: 100%;
    position: relative;
  }
  .voutline {
  }
</style>
