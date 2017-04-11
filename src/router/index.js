import Vue from 'vue'
import Router from 'vue-router'
import Dashboard from '@/components/Dashboard'
import TreeViewer from '@/components/TreeViewer'
import AccordionViewer from '@/components/AccordionViewer'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      component: Dashboard,
      children: [{
        name: 'Top',
        path: '',
        component: TreeViewer
      }]
    },
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
    }
  ]
})
