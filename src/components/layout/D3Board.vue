<template>
  <div style="text-align:center">
    <h1>{{title}}</h1>
    <mermaid
      :name=mmName
      height="600">
      {{mm}}
    </mermaid>
  </div>
</template>

<script>
  import Item from './Item'
  import _ from 'lodash'
  // let itemSet = null
  function addParentPointers (item) {
    item.name = item.name.replace(/@mermaid\w\w /, '')
    item.children.forEach(c => {
      c.parent = item
      c.o = false
      addParentPointers(c)
    })
  }
  function cleanTitle (title) {
    if (!/[\[{(]/.test(title)) { // eslint-disable-line
      title = '[' + title + ']'
    }
    return title
  }
  function getMm (item, links) {
    item.children.forEach(i => {
      let pname = cleanTitle(item.name)
      let cname = cleanTitle(i.name)
      links.push(`${item.t}${pname} --> ${i.t}${cname}`)
      getMm(i, links)
    })
  }
  export default {
    name: 'mermaid-board',
    components: {
      item: Item
    },
    methods: {
      main () {}
    },
    data () {
      return {
      //  links: []
      }
    },
    computed: {
      foo: function () {

        var svg = d3.select("svg"),
          width = +svg.attr("width"),
          height = +svg.attr("height");

        var color = d3.scaleOrdinal(d3.schemeCategory20);

        var simulation = d3.forceSimulation()
          .force("link", d3.forceLink().id(function(d) { return d.id; }))
          .force("charge", d3.forceManyBody())
          .force("center", d3.forceCenter(width / 2, height / 2));

        d3.json("miserables.json", function(error, graph) {
          if (error) throw error;

          var link = svg.append("g")
            .attr("class", "links")
            .selectAll("line")
            .data(graph.links)
            .enter().append("line")
            .attr("stroke-width", function(d) { return Math.sqrt(d.value); });

          var node = svg.append("g")
            .attr("class", "nodes")
            .selectAll("circle")
            .data(graph.nodes)
            .enter().append("circle")
            .attr("r", 5)
            .attr("fill", function(d) { return color(d.group); })
            .call(d3.drag()
              .on("start", dragstarted)
              .on("drag", dragged)
              .on("end", dragended));

          node.append("title")
            .text(function(d) { return d.id; });

          simulation
            .nodes(graph.nodes)
            .on("tick", ticked);

          simulation.force("link")
            .links(graph.links);

          function ticked() {
            link
              .attr("x1", function(d) { return d.source.x; })
              .attr("y1", function(d) { return d.source.y; })
              .attr("x2", function(d) { return d.target.x; })
              .attr("y2", function(d) { return d.target.y; });

            node
              .attr("cx", function(d) { return d.x; })
              .attr("cy", function(d) { return d.y; });
          }
        });

        function dragstarted(d) {
          if (!d3.event.active) simulation.alphaTarget(0.3).restart();
          d.fx = d.x;
          d.fy = d.y;
        }

        function dragged(d) {
          d.fx = d3.event.x;
          d.fy = d3.event.y;
        }

        function dragended(d) {
          if (!d3.event.active) simulation.alphaTarget(0);
          d.fx = null;
          d.fy = null;
        }

      },
      id: function () {
        if (!this.$route.params.id) {
          return +1
        } else {
          return this.$route.params.id
        }
      },
      mprops: function () {

      },
      data () {
        return this.$store.state.leodata
      },
      item () {
        const id = this.$store.state.currentItem.id
        return JSON.search(this.data, '//*[id="' + id + '"]')[0]
      },
      title () {
        return this.item.name.replace(/@mermaid\w\w /, '')
      },
      mmName () {
        return this.item.name
      },
      text () {
        return this.$store.state.leotext
      },
      itemSet () {
        // if (!itemSet) {
        let itemSet = _.cloneDeep(this.item)
        addParentPointers(itemSet)
        // }
        return itemSet
      },
      mm () {
        let links = []
        getMm(this.itemSet, links)
        links = _.uniq(links)
        links[0] = links[0].replace(/@mermaid\w? /, '')
        let graphType = 'LR'
        let m = this.item.name.match(/@mermaid([a-z][a-z])/)
        if (m) {
          graphType = m[1].toUpperCase()
        }
        links.unshift('graph ' + graphType + ';')
        console.log('LINKs:', links)
        return links.join('\n')

        /*        `
              graph TD;
              Anything-->B;
              Everything-->C;
              B-->D;
              C-->D;
        ` */
      }
    },
    mounted () {
    },
    watch: {
      '$route' (to, from) {
        // console.log(to, from)
      }
    }
  }
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style lang="sass" scoped>
  .links line {
    stroke: #999;
    stroke-opacity: 0.6;
  }

  .nodes circle {
    stroke: #fff;
    stroke-width: 1.5px;
  }
</style>
