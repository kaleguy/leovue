import Vue from 'vue'
import Router from 'vue-router'
import Dashboard from '@/components/Dashboard'
import TreeViewer from '@/components/TreeViewer'
import D3Viewer from '@/components/D3Viewer'
import DbViewer from '@/components/DbViewer'
import Settings from '@/components/Settings'
import AccordionViewer from '@/components/AccordionViewer'

Vue.use(Router)

// TODO: add not found link
export default new Router({
  routes: [
    {
      path: '/t/:id',
      component: Dashboard,
      children: [{
        name: 'Node',
        path: '',
        component: TreeViewer
      }]
    },
    {
      path: '/a/:id',
      component: Dashboard,
      children: [{
        name: 'ANode',
        path: '',
        component: AccordionViewer
      }]
    },
    {
      path: '/d/:id',
      component: Dashboard,
      children: [{
        name: 'DNode',
        path: '',
        component: D3Viewer
      }]
    },
    {
      path: '/z/:id',
      component: Dashboard,
      children: [{
        name: 'ZNode',
        path: '',
        component: D3Viewer
      }]
    },
    {
      path: '/r/:id',
      component: Dashboard,
      children: [{
        name: 'RNode',
        path: '',
        component: D3Viewer
      }]
    },
    {
      path: '/w/:id',
      component: Dashboard,
      children: [{
        name: 'WNode',
        path: '',
        component: DbViewer
      }]
    },
    {
      path: '/settings',
      component: Settings
    }
  ]
})
