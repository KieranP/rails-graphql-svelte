<script lang="ts">
  import { goto } from '$app/navigation'

  import { createUser } from '$lib/queries/user'
  import { setSession } from '$lib/helpers/session'
  import { errors } from '$lib/helpers/stores'
  import { allLocales, setLocale, _ } from '$lib/helpers/i18n'

  let name: string = $state('')
  let email: string = $state('')
  let locale: string = $state('')
  let password: string = $state('')
  let passwordConfirmation: string = $state('')

  function submit(event: SubmitEvent) {
    event.preventDefault()

    createUser(
      { name, email, locale, password, passwordConfirmation },
      `user { uuid name email locale }`
    )
      .then(res => {
        let data = res.data.createUser
        let user = data.user
        let uuid = user.uuid

        setSession(data)
        setLocale.set(user.locale)

        goto(`/users/${uuid}`)
      })
      .catch(error => {
        errors.set(error.graphQLErrors)
      })
  }
</script>

<h1>
  {$_('pages.users.new.heading')}
</h1>

<form onsubmit={submit}>
  <div class="mb-3">
    <label for="name" class="form-label">
      {$_('pages.users.new.name')}
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
    <label for="email" class="form-label">
      {$_('pages.users.new.email')}
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
    <label for="locale" class="form-label">
      {$_('pages.users.new.locale')}
    </label>

    <select class="form-select" bind:value={locale}>
      {#each $allLocales as _locale}
        <option value={_locale} selected={_locale == locale}>
          {_locale}
        </option>
      {/each}
    </select>
  </div>

  <div class="mb-3">
    <label for="password" class="form-label">
      {$_('pages.users.new.password')}
    </label>
    <input
      type="password"
      class="form-control"
      id="password"
      bind:value={password}
      required
    />
  </div>

  <div class="mb-3">
    <label for="password_confirmation" class="form-label">
      {$_('pages.users.new.password_confirmation')}
    </label>
    <input
      type="password"
      class="form-control"
      id="password_confirmation"
      bind:value={passwordConfirmation}
      required
    />
  </div>

  <div class="mb-3">
    <button type="submit" class="btn btn-primary">
      {$_('pages.users.new.button')}
    </button>
  </div>
</form>
