// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import * as bootstrap from "bootstrap"

import Vue from "vue/dist/vue.esm.browser"
import axios from "axios"

document.addEventListener('turbo:load', () => {
  const selector = '#liking-app'
  const element = document.querySelector(selector)
  const createPath = element.getAttribute('data-create-path')
  const likingUsersPath = element.getAttribute('data-liking-users-path')
  new Vue({
    el: selector,
    data: {
      users: [],
      destroyPath: undefined,
    },
    computed: {
      alreadyLiked() {
        return this.destroyPath
      }
    },
    async created() {
      await this.fetchLikingUsers()
    },
    methods: {
      fetchLikingUsers: async function () {
        const json = await axios.get(likingUsersPath)
        this.users = json.data.users
        this.destroyPath = json.data.destroy_path
      },
      create: async function () {
        await axios.post(createPath, {}, {
          headers: {
            'X-Requested-With': 'XMLHttpRequest',
            "X-CSRF-Token": this.token(),
          },
        })
        await this.fetchLikingUsers();
      },
      destroy: async function () {
        await axios.delete(this.destroyPath, {
          headers: {
            'X-Requested-With': 'XMLHttpRequest',
            "X-CSRF-Token": this.token(),
          },
        })
        await this.fetchLikingUsers();
      },
      token() {
        const meta = document.querySelector('meta[name="csrf-token"]')
        return meta ? meta.getAttribute('content') : ''
      }
    }
  })
})
