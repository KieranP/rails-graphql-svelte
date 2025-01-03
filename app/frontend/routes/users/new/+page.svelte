<script lang="ts">
  import { ApolloError } from '@apollo/client/core'

  import { goto } from '$app/navigation'

  import { _, allLocales, setLocale } from '$lib/helpers/i18n'
  import { setSession } from '$lib/helpers/session'
  import { errors } from '$lib/helpers/stores'
  import { createUser } from '$lib/queries/user'

  let name: string = $state('')
  let email: string = $state('')
  let locale: string = $state('')
  let password: string = $state('')
  let passwordConfirmation: string = $state('')

  function submit(event: SubmitEvent): void {
    event.preventDefault()

    createUser({ name, email, locale, password, passwordConfirmation })
      .then(async (res) => {
        if (!res.data?.createUser) return

        const data = res.data.createUser
        const user = data.user
        const uuid = user.uuid

        setSession(data)
        await setLocale.set(user.locale)

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
  {$_('pages.users.new.heading')}
</h1>

<form onsubmit={submit}>
  <div class="mb-3">
    <label
      class="form-label"
      for="name"
    >
      {$_('pages.users.new.name')}
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
      {$_('pages.users.new.email')}
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
      {$_('pages.users.new.locale')}
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
    <label
      class="form-label"
      for="password"
    >
      {$_('pages.users.new.password')}
    </label>
    <input
      id="password"
      class="form-control"
      required
      type="password"
      bind:value={password}
    />
  </div>

  <div class="mb-3">
    <label
      class="form-label"
      for="password_confirmation"
    >
      {$_('pages.users.new.password_confirmation')}
    </label>
    <input
      id="password_confirmation"
      class="form-control"
      required
      type="password"
      bind:value={passwordConfirmation}
    />
  </div>

  <div class="mb-3">
    <button
      class="btn btn-primary"
      type="submit"
    >
      {$_('pages.users.new.button')}
    </button>
  </div>
</form>
