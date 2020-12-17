<script>
  import { logoutUser } from '@libs/queries'
  import { session } from '@libs/stores'
  import { navigate } from 'svelte-navigator'

  logoutUser({}, `user { id }`).then(res => {
    if (res.errors) {
      errors.set(res.errors)
    } else {
      localStorage.clear()
      session.set({})
      navigate('/')
    }
  })
</script>
