<template>
  <div class="word-cloud">
    <vue-word-cloud
      :words="chapters"
      :color="([, weight]) => weight > 50 ? 'DeepPink' : weight > 25 ? 'RoyalBlue' : 'Indigo'"
      font-family="Roboto"
    />
  </div>
</template>

<script>
  import _ from 'lodash'
  import util from '../util'
  const sw = require('stopword')
  const split = require('split-string-words')
  export default {
    name: 'word-cloud',
    components: {
    },
    props: {
      group: {
        type: String,
        default: ''
      },
      from: {
        type: String,
        default: ''
      },
      threshold: {
        type: Number,
        default: 11
      }
    },
    data: () => ({
      messageWhenNoItems: 'There are no items.'
    }),
    computed: {
      chapters () {
        let data = this.$store.state.leodata
        const item = JSON.search(data, '//*[group="' + this.group + '"]')[0]
        const children = item.children
        const items = []
        const textItems = this.$store.state.leotext
        children.forEach(child => {
          const t = textItems[child.t]
          let textData = {}
          try {
            textData = JSON.parse(t)
          } catch (e) {
            console.log(e, child.id)
          }
          items.push(_.get(textData, this.from, ''))
        })
        let text = items.join()
        // text = stripchar.RSspecChar(text.toLowerCase())
        text = text.replace(/[[\]&,;'"”’().*?]/g, ' ')
        let words = split(text)
        words = sw.removeStopwords(words)
        const wf = {}
        _.remove(words, word => /\d/.test(word))
        words.forEach(word => {
          if (word.length < 4) { return }
          word = word.toLowerCase()
          wf[word] = wf[word] ? wf[word] + 1 : 1
        })
        // debugger
        const wordFreq = {}
        Object.keys(wf).forEach(k => {
          const v = wf[k]
          if (v > this.threshold) wordFreq[k] = v
        })
        const keys = Object.keys(wordFreq)
        keys.forEach(k => {
          if (wordFreq[k + 's']) {
            wordFreq[k] = wordFreq[k] + wordFreq[k + 's']
            delete wordFreq[k + 's'] // combine plural with singular count
          }
          if (wordFreq[k + 'd']) {
            wordFreq[k] = wordFreq[k] + wordFreq[k + 'd']
            delete wordFreq[k + 'd'] // combine past tense with present count
          }
          if (wordFreq[k + 'ly']) {
            wordFreq[k] = wordFreq[k] + wordFreq[k + 'ly']
            delete wordFreq[k + 'ly'] // combine adverb form with adj count
          }
        })
        const c = []
        Object.keys(wordFreq).forEach(key => {
          const a = []
          a.push(key)
          a.push(wordFreq[key])
          c.push(a)
        })
        return c
      }
    },
    methods: {
      dataTableClick: function (r) {
        this.$parent.$parent.dataTableClick(r)
      },
      gotoSection: function (title) {
        const plainTitle = _.trim(title)
        const searchTitle = '« ' + plainTitle + ' »'
        let leodata = this.$store.state.leodata
        if (window.parent !== window.self) {
          leodata = window.parent.lconfig.leodata
        }
        let titleObj = JSON.search(leodata, '//*[vtitle="' + searchTitle + '"]')[0]
        if (!titleObj) {
          let i = 0
          while (!titleObj && (i < leodata.length)) {
            titleObj = util.getObjectByKeyFromTree(leodata[i], 'vtitle', plainTitle)
            i = i + 1
          }
        }
        let id = null
        let index = null
        if (titleObj) {
          id = titleObj.id
          if (titleObj.index) {
            index = titleObj.index
          }
          this.$store.dispatch('setCurrentItem', {id})
          if (window.parent !== window.self) {
            console.log('posting message')
            window.parent.postMessage(JSON.stringify({
              namespace: 'leovue',
              eventName: 'setcurrentitem',
              state: {id, index}
            }), '*')
          }
        }
      }
    }
  }
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style lang="sass" scoped>
.word-cloud
 padding: 10px
</style>
