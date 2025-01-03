<script lang="ts">
  import { ApolloError } from '@apollo/client/core'

  import { goto } from '$app/navigation'
  import { page } from '$app/stores'

  import { _ } from '$lib/helpers/i18n'
  import { errors } from '$lib/helpers/stores'
  import { base64Decode } from '$lib/helpers/utils'
  import { resetPassword } from '$lib/queries/user'

  const token: string = base64Decode($page.params['token'])
  const email: string = base64Decode($page.params['email'])

  let password: string = $state('')
  let passwordConfirmation: string = $state('')

  function submit(event: SubmitEvent): void {
    event.preventDefault()

    resetPassword({ token, email, password, passwordConfirmation })
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
      class="form-label"
      for="email"
    >
      {$_('pages.reset-password.email')}
    </label>
    <input
      id="email"
      class="form-control"
      readonly
      required
      type="email"
      value={email}
    />
  </div>

  <div class="mb-3">
    <label
      class="form-label"
      for="password"
    >
      {$_('pages.reset-password.password')}
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
      {$_('pages.reset-password.password_confirmation')}
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
      {$_('pages.reset-password.button')}
    </button>
  </div>
</form>
