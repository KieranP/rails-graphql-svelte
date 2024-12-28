<script lang="ts">
  import { onMount } from 'svelte'

  import { ApolloError } from '@apollo/client/core'

  import { goto } from '$app/navigation'

  import { setLocale } from '$lib/helpers/i18n'
  import { clearSession } from '$lib/helpers/session'
  import { errors } from '$lib/helpers/stores'
  import { logoutUser } from '$lib/queries/auth'

  onMount(() => {
    logoutUser()
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
