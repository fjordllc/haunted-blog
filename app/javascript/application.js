// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import * as bootstrap from "bootstrap"

import Vue from "vue/dist/vue.esm.browser"
document.addEventListener('turbo:load', () => {
  const app = new Vue({
    el: '#app',
    data: {
      message: 'Hello Vue!'
    }
  })
})
