<script>
  import { logoutUser } from '@libs/queries'
  import { session, errors } from '@libs/stores'
  import { goto } from '@roxi/routify'

  logoutUser({}, `user { id }`).then(res => {
    localStorage.clear()
    session.set({})
    $goto('/')
  }).catch(error => {
    errors.set(error.graphQLErrors)
  })
</script>
