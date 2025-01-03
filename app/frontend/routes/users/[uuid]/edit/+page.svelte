<script lang="ts">
  import { ApolloError } from '@apollo/client/core'

  import { goto } from '$app/navigation'
  import { page } from '$app/stores'

  import Loader from '$lib/components/loader.svelte'
  import { _, allLocales, setLocale } from '$lib/helpers/i18n'
  import { setSession } from '$lib/helpers/session'
  import { errors } from '$lib/helpers/stores'
  import { findUser, updateUser } from '$lib/queries/user'

  import type { User } from '$lib/types/user'

  const uuid = $derived($page.params['uuid'])

  let user: User | undefined = $state()
  let name: string = $state('')
  let email: string = $state('')
  let locale: string = $state('')

  $effect(() => {
    findUser({ uuid }, `uuid name email locale otpEnabled`)
      .then((res) => {
        user = res.data.findUser
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

  function submit(event: SubmitEvent): void {
    event.preventDefault()

    updateUser({ uuid, name, email, locale }, `user { uuid name email locale }`)
      .then(async (res) => {
        if (!res.data?.updateUser) return

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
          class="form-label"
          for="name"
        >
          {$_('pages.users.edit.name')}
        </label>
        <input
          id="name"
          class="form-control"
          required
          type="text"
          bind:value={name}
        />
      </div>

      <div class="mb-3">
        <label
          class="form-label"
          for="email"
        >
          {$_('pages.users.edit.email')}
        </label>
        <input
          id="email"
          class="form-control"
          required
          type="email"
          bind:value={email}
        />
      </div>

      <div class="mb-3">
        <label
          class="form-label"
          for="locale"
        >
          {$_('pages.users.edit.locale')}
        </label>

        <select
          class="form-select"
          bind:value={locale}
        >
          {#each $allLocales as _locale (_locale)}
            <option
              selected={_locale === locale}
              value={_locale}
            >
              {_locale}
            </option>
          {/each}
        </select>
      </div>

      <div class="mb-3">
        <button
          class="btn btn-primary"
          type="submit"
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
