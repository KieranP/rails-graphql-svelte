<script lang="ts">
  import { ApolloError } from '@apollo/client/core'

  import { goto } from '$app/navigation'

  import { setLocale } from '$lib/helpers/i18n'
  import { clearSession } from '$lib/helpers/session'
  import { errors } from '$lib/helpers/stores'
  import { logoutUser } from '$lib/queries/auth'

  $effect(() => {
    logoutUser({}, `user { uuid }`)
      .then(async () => {
        clearSession()
        await setLocale.set('en')

        void goto('/')
      })
      .catch((error: unknown) => {
        if (error instanceof ApolloError) {
          errors.set(error.graphQLErrors)
        }
      })
  })
</script>
