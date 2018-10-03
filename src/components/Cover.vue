<template>
  <div>
  <section class="cover show" id="cover-page" v-if="coverContent">
    <component :is="dynComponent" />
  </section>
  </div>
</template>

<script>
  export default {
    name: 'cover',
    data () {
      return {
      }
    },
    methods: {
    },
    components: {},
    computed: {
      coverContent () {
        return this.$store.state.cover
      },
      dynComponent () {
        // const id = this.$store.state.currentItem.id
        const template = this.coverContent ? this.coverContent : '<div></div>'
        return {
          template
        }
      }

    },
    mounted () {
    },
    updated () {
    }
  }
</script>

//MathJax.Hub.Queue(["Typeset",MathJax.Hub,"MathExample"]);

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style>

  section {
    --theme-color: #0c0;
  }

  section.cover {
    -ms-flex-align: center;
    align-items: center;
    background-position: 50%;
    background-repeat: no-repeat;
    background-size: cover;
    height: 100vh;
    display: none
  }

  section.cover.show {
    display: -ms-flexbox;
    display: flex
  }

  section.cover.has-mask .mask {
    background-color: #3f3f3f;
    opacity: .8;
    position: absolute;
    top: 0;
    height: 100%;
    width: 100%
  }

  section.cover .cover-main {
    -ms-flex: 1;
    flex: 1;
    text-align: center;
    z-index: 1
  }

  section.cover a {
    color: inherit
  }

  section.cover a,section.cover a:hover {
    text-decoration: none
  }

  section.cover p {
    line-height: 1rem;
    margin: 0
  }

  section.cover h1 {
    color: inherit;
    font-size: 2.5rem;
    font-weight: 300;
    margin: .625rem 0 2.5rem;
    position: relative;
    text-align: center
  }

  section.cover h1 a {
    display: block
  }

  section.cover h1 small {
    bottom: -.4375rem;
    font-size: 1rem;
    position: absolute
  }

  section.cover blockquote {
    font-size: 1.5rem;
    text-align: center
  }

  section.cover ul {
    line-height: 1.8;
    list-style-type: none;
    margin: 1em auto;
    max-width: 500px;
    padding: 0
  }

  section.cover .cover-main p a {
    border: 1px solid var(--theme-color,#ea6f5a);
    border-radius: 2rem;
    box-sizing: border-box;
    color: var(--theme-color,#ea6f5a);
    display: inline-block;
    font-size: 1.05rem;
    letter-spacing: .1rem;
    margin: .5rem 1rem;
    padding: .75em 2rem;
    text-decoration: none;
    transition: all .15s ease
  }

  section.cover .cover-main p a {
    background-color: var(--theme-color);
    color: #fff
  }

  section.cover .cover-main>p:last-child a:last-child:hover {
    color: inherit;
    opacity: .8
  }

  section.cover .cover-main>p:last-child a:hover {
    color: inherit
  }

  section.cover blockquote>p>a {
    border-bottom: 2px solid var(--theme-color,#ea6f5a);
    transition: color .3s
  }

  section.cover blockquote>p>a:hover {
    color: var(--theme-color,#ea6f5a)
  }
  section.cover .carousel-caption {
    left: 4%;
    right: 4%;
    bottom: 15%;
  }

  section.cover .carousel-caption P,
  section.cover .carousel-caption H3 {
    background-color:#000;
    border-radius: 10px;
    display:inline-block;
    padding: 6px;
    padding-left: 20px;
    padding-right: 20px;
    box-shadow: 3px 3px 10px #666;
  }
  section.cover .app-title {
    font-size: 70px;
    display: inline-block;
    padding-top: 15px;
    padding-bottom: 0px;
  }
  section.cover .carousel-control-next-icon {
    background-color: #555;
    border-radius: 15px;
  }
  section.cover .carousel-control-prev-icon {
    background-color: #555;
    border-radius: 15px;
  }
  section .carousel-indicators .active {
    background-color: #000;
  }
  section .carousel-indicators LI {
    background-color: #ccc;
  }
  section .carousel-indicators {
    bottom: -20px;
  }
  section IMG {
    outline: none
  }

</style>
