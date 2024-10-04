<script lang="ts">
  import { ApolloError } from '@apollo/client/core'

  import { goto } from '$app/navigation'
  import { page } from '$app/stores'

  import { _ } from '$lib/helpers/i18n'
  import { errors } from '$lib/helpers/stores'
  import { base64Decode } from '$lib/helpers/utils'
  import { resetPassword } from '$lib/queries/user'

  const token: string = base64Decode($page.params.token)
  const email: string = base64Decode($page.params.email)

  let password: string = $state('')
  let passwordConfirmation: string = $state('')

  function submit(event: SubmitEvent) {
    event.preventDefault()

    resetPassword({ token, email, password, passwordConfirmation }, `success`)
      .then(() => {
        void goto('/login')
      })
      .catch((error: unknown) => {
        if (error instanceof ApolloError) {
          errors.set(error.graphQLErrors)
        }
      })
  }
</script>

<h1>
  {$_('pages.reset-password.heading')}
</h1>

<form onsubmit={submit}>
  <div class="mb-3">
    <label
      for="email"
      class="form-label"
    >
      {$_('pages.reset-password.email')}
    </label>
    <input
      type="email"
      class="form-control"
      id="email"
      value={email}
      required
      readonly
    />
  </div>

  <div class="mb-3">
    <label
      for="password"
      class="form-label"
    >
      {$_('pages.reset-password.password')}
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
    <label
      for="password_confirmation"
      class="form-label"
    >
      {$_('pages.reset-password.password_confirmation')}
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
    <button
      type="submit"
      class="btn btn-primary"
    >
      {$_('pages.reset-password.button')}
    </button>
  </div>
</form>
