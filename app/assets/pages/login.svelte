<script>
  import { loginUser } from '@queries/auth'
  import { setSession } from '@libs/session'
  import { errors } from '@libs/stores'
  import { setLocale, _ } from '@libs/i18n'
  import { goto } from '@roxi/routify'

  let email
  let password

  function submit() {
    loginUser({email, password}, `user { uuid email name locale }`).then(res => {
      let data = res.data.loginUser
      let user = data.user

      setSession(data)
      setLocale.set(user.locale)

      $goto('/')
    }).catch(error => {
      errors.set(error.graphQLErrors)
    })
  }
</script>

<h1>
  {$_('pages.auth.login.heading')}
</h1>

<form on:submit|preventDefault={submit}>
  <div class="mb-3">
    <label for="email" class="form-label">
      {$_('pages.auth.login.email')}
    </label>
    <input type="email" class="form-control" id="email" bind:value={email} required />
  </div>

  <div class="mb-3">
    <label for="password" class="form-label">
      {$_('pages.auth.login.password')}
    </label>
    <input type="password" class="form-control" id="password" bind:value={password} required />
  </div>

  <div class="mb-3">
    <button type="submit" class="btn btn-primary">
      {$_('pages.auth.login.button')}
    </button>
  </div>
</form>
