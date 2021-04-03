<script>
  import { createUser } from '@queries/user'
  import { setSession } from '@libs/session'
  import { errors } from '@libs/stores'
  import { goto } from '@roxi/routify'
  import { allLocales, setLocale, _ } from '@libs/i18n'

  let name
  let email
  let locale
  let password
  let passwordConfirmation

  function submit() {
    createUser(
      {name, email, locale, password, passwordConfirmation},
      `user { uuid name email locale }`
    ).then(res => {
      let data = res.data.createUser
      let user = data.user
      let uuid = user.uuid

      setSession(data)
      setLocale.set(user.locale)

      $goto('/users/:uuid', {uuid})
    }).catch(error => {
      errors.set(error.graphQLErrors)
    })
  }
</script>

<h1>
  {$_('pages.users.new.heading')}
</h1>

<form on:submit|preventDefault={submit}>
  <div class="mb-3">
    <label for="name" class="form-label">
      {$_('pages.users.new.name')}
    </label>
    <input type="text" class="form-control" id="name" bind:value={name} required />
  </div>

  <div class="mb-3">
    <label for="email" class="form-label">
      {$_('pages.users.new.email')}
    </label>
    <input type="email" class="form-control" id="email" bind:value={email} required />
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
    <input type="password" class="form-control" id="password" bind:value={password} required />
  </div>

  <div class="mb-3">
    <label for="password_confirmation" class="form-label">
      {$_('pages.users.new.password_confirmation')}
    </label>
    <input type="password" class="form-control" id="password_confirmation" bind:value={passwordConfirmation} required />
  </div>

  <div class="mb-3">
    <button type="submit" class="btn btn-primary">
      {$_('pages.users.new.button')}
    </button>
  </div>
</form>
