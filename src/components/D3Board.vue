<template>
  <div>
    <svg width='800'
         height='600'
         id='d3board-svg'
    >

    </svg>
  </div>
</template>

<script>
  import * as d3 from 'd3'

  var graph = {
    'nodes': [
      { 'x': 208.992345, 'y': 273.053211 },
      { 'x': 595.98896, 'y': 56.377057 },
      { 'x': 319.568434, 'y': 278.523637 },
      { 'x': 214.494264, 'y': 214.893585 },
      { 'x': 482.664139, 'y': 340.386773 },
      { 'x': 84.078465, 'y': 192.021902 },
      { 'x': 196.952261, 'y': 370.798667 },
      { 'x': 107.358165, 'y': 435.15643 },
      { 'x': 401.168523, 'y': 443.407779 },
      { 'x': 508.368779, 'y': 386.665811 },
      { 'x': 355.93773, 'y': 460.158711 },
      { 'x': 283.630624, 'y': 87.898162 },
      { 'x': 194.771218, 'y': 436.366028 },
      { 'x': 477.520013, 'y': 337.547331 },
      { 'x': 572.98129, 'y': 453.668459 },
      { 'x': 106.717817, 'y': 235.990363 },
      { 'x': 265.064649, 'y': 396.904945 },
      { 'x': 452.719997, 'y': 137.886092 }
    ],
    'links': [
      { 'target': 11, 'source': 0 },
      { 'target': 3, 'source': 0 },
      { 'target': 10, 'source': 0 },
      { 'target': 16, 'source': 0 },
      { 'target': 1, 'source': 0 },
      { 'target': 3, 'source': 0 },
      { 'target': 9, 'source': 0 },
      { 'target': 5, 'source': 0 },
      { 'target': 11, 'source': 0 },
      { 'target': 13, 'source': 0 },
      { 'target': 16, 'source': 0 },
      { 'target': 3, 'source': 1 },
      { 'target': 9, 'source': 1 },
      { 'target': 12, 'source': 1 },
      { 'target': 4, 'source': 2 },
      { 'target': 6, 'source': 2 },
      { 'target': 8, 'source': 2 },
      { 'target': 13, 'source': 2 },
      { 'target': 10, 'source': 3 },
      { 'target': 16, 'source': 3 },
      { 'target': 9, 'source': 3 },
      { 'target': 7, 'source': 3 },
      { 'target': 11, 'source': 5 },
      { 'target': 13, 'source': 5 },
      { 'target': 12, 'source': 5 },
      { 'target': 8, 'source': 6 },
      { 'target': 13, 'source': 6 },
      { 'target': 10, 'source': 7 },
      { 'target': 11, 'source': 7 },
      { 'target': 17, 'source': 8 },
      { 'target': 13, 'source': 8 },
      { 'target': 11, 'source': 10 },
      { 'target': 16, 'source': 10 },
      { 'target': 13, 'source': 11 },
      { 'target': 14, 'source': 12 },
      { 'target': 14, 'source': 12 },
      { 'target': 14, 'source': 12 },
      { 'target': 15, 'source': 12 },
      { 'target': 16, 'source': 12 },
      { 'target': 15, 'source': 14 },
      { 'target': 16, 'source': 14 },
      { 'target': 15, 'source': 14 },
      { 'target': 16, 'source': 15 },
      { 'target': 16, 'source': 15 },
      { 'target': 17, 'source': 16 }
    ]
  }

  export default {
    name: 'd3-board',
    components: {
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
    },
    mounted () {
      let svg = document.getElementById('d3board-svg')
      const width = 600
      const height = 400
      const nodes = graph.nodes
      const links = graph.links
      const force = d3.forceSimulation()
        .size([width, height])
        .nodes(nodes)
        .links(links)
      force.linkDistance(width / 3.05)
      const link = svg.selectAll('.link')
        .data(links)
        .enter().append('line')
        .attr('class', 'link')
      const node = svg.selectAll('.node')
        .data(nodes)
        .enter().append('circle')
        .attr('class', 'node')
      force.on('end', () => {
        node.attr('r', width / 100)
          .attr('cx', d => d.x)
          .attr('cy', d => d.y)
        link.attr('x1', d => d.source.x)
          .attr('y1', d => d.source.y)
          .attr('x2', d => d.target.x)
          .attr('y2', d => d.target.y)
      })
      force.start()
    },
    watch: {
      '$route' (to, from) {
        // console.log(to, from)
      }
    }
  }
</script>

<!-- Add 'scoped' attribute to limit CSS to this component only -->
<style lang='sass' scoped>
  .links line
    stroke: #999
    stroke-opacity: 0.2
  .nodes circle
    stroke: #fff
    stroke-width: 1.5px
</style>
