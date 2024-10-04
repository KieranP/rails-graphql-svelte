<script lang="ts">
  import { ApolloError } from '@apollo/client/core'

  import { _ } from '$lib/helpers/i18n'
  import { errors } from '$lib/helpers/stores'
  import { forgotPassword } from '$lib/queries/user'

  let email: string = $state('')
  let result: object | undefined = $state()

  function submit(event: SubmitEvent) {
    event.preventDefault()

    forgotPassword({ email }, `success`)
      .then(res => {
        errors.set([])
        result = res.data.forgotPassword
      })
      .catch((error: unknown) => {
        if (error instanceof ApolloError) {
          errors.set(error.graphQLErrors)
        }
      })
  }
</script>

<h1>
  {$_('pages.forgot-password.heading')}
</h1>

{#if result}
  {$_('pages.forgot-password.success')}
{:else}
  <form onsubmit={submit}>
    <div class="mb-3">
      <label
        for="email"
        class="form-label"
      >
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
      <button
        type="submit"
        class="btn btn-primary"
      >
        {$_('pages.forgot-password.button')}
      </button>
    </div>
  </form>
{/if}
