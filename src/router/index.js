import Vue from 'vue'
import Router from 'vue-router'
import Dashboard from '@/components/Dashboard'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'TreeView',
      component: Dashboard
    },
    {
      path: '/t/:id',
      name: 'Node',
      component: Dashboard
    }

  ]
})
