<script lang="ts">
  import { goto } from '$app/navigation'

  import { logoutUser } from '$lib/queries/auth'
  import { clearSession } from '$lib/helpers/session'
  import { errors } from '$lib/helpers/stores'
  import { setLocale } from '$lib/helpers/i18n'

  logoutUser({}, `user { uuid }`)
    .then(() => {
      clearSession()
      setLocale.set('en')

      goto('/')
    })
    .catch(error => {
      errors.set(error.graphQLErrors)
    })
</script>
