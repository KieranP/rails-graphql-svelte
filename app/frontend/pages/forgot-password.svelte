<script lang="ts">
  import { forgotPassword } from '@queries/user'
  import { errors } from '@libs/stores'
  import { _ } from '@libs/i18n'

  let email: string
  let result: object

  function submit() {
    forgotPassword({ email }, `success`)
      .then(res => {
        errors.set([])
        result = res.data.forgotPassword
      })
      .catch(error => {
        errors.set(error.graphQLErrors)
      })
  }
</script>

<h1>
  {$_('pages.forgot-password.heading')}
</h1>

{#if result}
  {$_('pages.forgot-password.success')}
{:else}
  <form on:submit|preventDefault={submit}>
    <div class="mb-3">
      <label for="email" class="form-label">
        {$_('pages.forgot-password.email')}
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
      <button type="submit" class="btn btn-primary">
        {$_('pages.forgot-password.button')}
      </button>
    </div>
  </form>
{/if}
