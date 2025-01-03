<script lang="ts">
  import { ApolloError } from '@apollo/client/core'

  import { _ } from '$lib/helpers/i18n'
  import { errors } from '$lib/helpers/stores'
  import { forgotPassword } from '$lib/queries/user'

  let email: string = $state('')
  let result: object | undefined = $state()

  function submit(event: SubmitEvent): void {
    event.preventDefault()

    forgotPassword({ email })
      .then((res) => {
        if (!res.data?.forgotPassword) return

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
        class="form-label"
        for="email"
      >
        {$_('pages.forgot-password.email')}
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
      <button
        class="btn btn-primary"
        type="submit"
      >
        {$_('pages.forgot-password.button')}
      </button>
    </div>
  </form>
{/if}
