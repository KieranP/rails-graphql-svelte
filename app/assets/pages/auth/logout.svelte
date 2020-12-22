<script>
  import { logoutUser } from '@libs/queries'
  import { session, errors } from '@libs/stores'
  import { navigate } from 'svelte-navigator'

  logoutUser({}, `user { id }`).then(res => {
    localStorage.clear()
    session.set({})
    navigate('/')
  }).catch(error => {
    errors.set(error.graphQLErrors)
  })
</script>
