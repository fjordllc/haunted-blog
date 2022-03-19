import Vue from "vue/dist/vue.esm.browser"
import LikingApp from './LikingApp.js'

document.addEventListener('DOMContentLoaded', () => {
  const selector = '#liking-app'
  const app = document.querySelector(selector)
  if (app) {
    const createPath = app.getAttribute('data-create-path')
    const likingUsersPath = app.getAttribute('data-liking-users-path')
    new Vue({
      render: (h) => h(LikingApp, {
        props: {
          createPath,
          likingUsersPath
        }
      })
    }).$mount(selector)
  }
})
