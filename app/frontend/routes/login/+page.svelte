<script lang="ts">
  import { ApolloError } from '@apollo/client/core'

  import { goto } from '$app/navigation'

  import { _, setLocale } from '$lib/helpers/i18n'
  import { setSession } from '$lib/helpers/session'
  import { errors } from '$lib/helpers/stores'
  import { loginUser } from '$lib/queries/auth'

  let email: string = $state('')
  let password: string = $state('')
  let otpRequired = $state(false)
  let otpCode: string = $state('')

  function submit(event: SubmitEvent): void {
    event.preventDefault()

    loginUser({ email, password, otpCode })
      .then(async (res) => {
        if (!res.data?.loginUser) return

        const data = res.data.loginUser
        const user = data.user

        setSession(data)
        await setLocale.set(user.locale)

        void goto('/')
      })
      .catch((error: unknown) => {
        if (error instanceof ApolloError) {
          const gqlErrors = error.graphQLErrors
          if (gqlErrors[0]?.message === 'otp_code_required') {
            otpRequired = true
          } else {
            errors.set(gqlErrors)
          }
        }
      })
  }
</script>

<h1>
  {$_('pages.login.heading')}
</h1>

<form onsubmit={submit}>
  <div class="mb-3">
    <label
      class="form-label"
      for="email"
    >
      {$_('pages.login.email')}
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
      for="password"
    >
      {$_('pages.login.password')}
    </label>
    <input
      id="password"
      class="form-control"
      required
      type="password"
      bind:value={password}
    />
  </div>

  {#if otpRequired}
    <div class="mb-3">
      <label
        class="form-label"
        for="otp_code"
      >
        {$_('pages.login.otp_code')}
      </label>
      <input
        id="otp_code"
        class="form-control"
        required
        type="text"
        bind:value={otpCode}
      />
    </div>
  {/if}

  <div class="mb-3">
    <button
      class="btn btn-primary"
      type="submit"
    >
      {$_('pages.login.button')}
    </button>

    <a href="/forgot-password">
      {$_('pages.login.forgot_password')}
    </a>
  </div>
</form>
