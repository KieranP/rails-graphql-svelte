<script lang="ts">
  import { params, goto } from '@roxi/routify'
  import { resetPassword } from '@queries/user'
  import { errors } from '@libs/stores'
  import { base64Decode } from '@libs/utils'
  import { _ } from '@libs/i18n'

  let token:string
  let email:string
  let password:string
  let passwordConfirmation:string

  $: token = base64Decode($params.token)
  $: email = base64Decode($params.email)

  function submit() {
    resetPassword({token, email, password, passwordConfirmation}, `success`).then(_res => {
      $goto('/login')
    }).catch(error => {
      errors.set(error.graphQLErrors)
    })
  }
</script>

<h1>
  {$_('pages.reset-password.heading')}
</h1>

<form on:submit|preventDefault={submit}>
  <div class="mb-3">
    <label for="email" class="form-label">
      {$_('pages.reset-password.email')}
    </label>
    <input type="email" class="form-control" id="email" bind:value={email} required readonly />
  </div>

  <div class="mb-3">
    <label for="password" class="form-label">
      {$_('pages.reset-password.password')}
    </label>
    <input type="password" class="form-control" id="password" bind:value={password} required />
  </div>

  <div class="mb-3">
    <label for="password_confirmation" class="form-label">
      {$_('pages.reset-password.password_confirmation')}
    </label>
    <input type="password" class="form-control" id="password_confirmation" bind:value={passwordConfirmation} required />
  </div>

  <div class="mb-3">
    <button type="submit" class="btn btn-primary">
      {$_('pages.reset-password.button')}
    </button>
  </div>
</form>
