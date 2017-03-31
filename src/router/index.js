import Vue from 'vue'
import Router from 'vue-router'
// import Dashboard from '@/components/Dashboard'
import TreeViewer from '@/components/TreeViewer'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'TreeView',
      component: TreeViewer
    },
    {
      path: '/t/:id',
      name: 'Node',
      component: TreeViewer
    }

  ]
})
