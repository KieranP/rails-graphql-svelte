<script lang="ts">
  import { ApolloError } from '@apollo/client/core'

  import { goto } from '$app/navigation'
  import { page } from '$app/stores'

  import Loader from '$lib/components/loader.svelte'
  import { _, allLocales, setLocale } from '$lib/helpers/i18n'
  import { setSession } from '$lib/helpers/session'
  import { errors } from '$lib/helpers/stores'
  import { findUser, updateUser } from '$lib/queries/user'

  import type { User } from '$lib/types/User'

  const uuid = $derived($page.params.uuid)

  let user: User | undefined = $state()
  let name: string = $state('')
  let email: string = $state('')
  let locale: string = $state('')

  $effect(() => {
    findUser({ uuid }, `uuid name email locale otpEnabled`)
      .then(res => {
        user = res.data.findUser as User
        name = user.name
        email = user.email
        locale = user.locale
      })
      .catch((error: unknown) => {
        if (error instanceof ApolloError) {
          errors.set(error.graphQLErrors)
        }
      })
  })

  function submit(event: SubmitEvent) {
    event.preventDefault()

    updateUser({ uuid, name, email, locale }, `user { uuid name email locale }`)
      .then(async res => {
        const data = res.data.updateUser
        const updated_user = data.user

        setSession(data)
        await setLocale.set(updated_user.locale)

        void goto(`/users/${uuid}`)
      })
      .catch((error: unknown) => {
        if (error instanceof ApolloError) {
          errors.set(error.graphQLErrors)
        }
      })
  }
</script>

<h1>
  {$_('pages.users.edit.heading')}
</h1>

<Loader>
  {#if user}
    <form onsubmit={submit}>
      <div class="mb-3">
        <label
          for="name"
          class="form-label"
        >
          {$_('pages.users.edit.name')}
        </label>
        <input
          type="text"
          class="form-control"
          id="name"
          bind:value={name}
          required
        />
      </div>

      <div class="mb-3">
        <label
          for="email"
          class="form-label"
        >
          {$_('pages.users.edit.email')}
        </label>
        <input
          type="email"
          class="form-control"
          id="email"
          bind:value={email}
          required
        />
      </div>

      <div class="mb-3">
        <label
          for="locale"
          class="form-label"
        >
          {$_('pages.users.edit.locale')}
        </label>

        <select
          class="form-select"
          bind:value={locale}
        >
          {#each $allLocales as _locale}
            <option
              value={_locale}
              selected={_locale === locale}
            >
              {_locale}
            </option>
          {/each}
        </select>
      </div>

      <div class="mb-3">
        <button
          type="submit"
          class="btn btn-primary"
        >
          {$_('common.update')}
        </button>

        <a href="/users/{uuid}/mfa">
          {#if user.otpEnabled}
            {$_('pages.users.edit.mfa-disable')}
          {:else}
            {$_('pages.users.edit.mfa-enable')}
          {/if}
        </a>
      </div>
    </form>
  {/if}
</Loader>
