export default {
  template: `
    <div>
      <span v-if="alreadyLiked">
        <button @click="destroy" class="btn btn-link btn-like"><i class="bi bi-hand-thumbs-up-fill" /></button>
      </span>
      <span v-else>
        <button @click="create" class="btn btn-link btn-like"><i class="bi bi-hand-thumbs-up" /></button>
      </span>
      <span class="liked-by" v-if="anyoneLiked">
        Liked by
        <ul>
          <li v-for="user in users" :key="user.id" class="cat-item">{{ user.nickname }}</li>
        </ul>
      </span>
      <span class="liked-by" v-else>
        Hit first like!
      </span>
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
    },
    anyoneLiked() {
      return this.users.length > 0
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
