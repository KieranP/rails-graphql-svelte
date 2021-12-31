<script lang="ts">
  import { loginUser } from '~/queries/auth'
  import { setSession } from '~/libs/session'
  import { errors } from '~/libs/stores'
  import { setLocale, _ } from '~/libs/i18n'
  import { goto, url } from '@roxi/routify'

  let email: string
  let password: string
  let otpRequired: boolean = false
  let otpCode: string

  function submit() {
    loginUser({ email, password, otpCode }, `user { uuid email name locale }`)
      .then(res => {
        let data = res.data.loginUser
        let user = data.user

        setSession(data)
        setLocale.set(user.locale)

        $goto('/')
      })
      .catch(res => {
        const gqlErrors = res.graphQLErrors
        if (gqlErrors[0].message == 'otp_code_required') {
          otpRequired = true
        } else {
          errors.set(gqlErrors)
        }
      })
  }
</script>

<h1>
  {$_('pages.login.heading')}
</h1>

<form on:submit|preventDefault={submit}>
  <div class="mb-3">
    <label for="email" class="form-label">
      {$_('pages.login.email')}
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
    <label for="password" class="form-label">
      {$_('pages.login.password')}
    </label>
    <input
      type="password"
      class="form-control"
      id="password"
      bind:value={password}
      required
    />
  </div>

  {#if otpRequired}
    <div class="mb-3">
      <label for="otp_code" class="form-label">
        {$_('pages.login.otp_code')}
      </label>
      <input
        type="text"
        class="form-control"
        id="otp_code"
        bind:value={otpCode}
        required
      />
    </div>
  {/if}

  <div class="mb-3">
    <button type="submit" class="btn btn-primary">
      {$_('pages.login.button')}
    </button>

    <a href={$url('/forgot-password')}>
      {$_('pages.login.forgot_password')}
    </a>
  </div>
</form>
