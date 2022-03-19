import axios from "axios"

export default {
  template: `
    <div>
      <div v-if="alreadyLiked">
        <button @click="destroy">Cancel Like</button>
      </div>
      <div v-else>
        <button @click="create">Like</button>
      </div>
      <ul>
        <li v-for="user in users" :key="user.id">{{ user.nickname }}</li>
      </ul>
    </div>
  `,
  props: {
    createPath: { type: String, required: true },
    likingUsersPath:  { type: String, required: true }
  },
  data() {
    return {
      users: [],
      destroyPath: undefined,
    }
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
      const json = await axios.get(this.likingUsersPath)
      this.users = json.data.users
      this.destroyPath = json.data.destroy_path
    },
    create: async function () {
      await axios.post(this.createPath, {}, {
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
}
