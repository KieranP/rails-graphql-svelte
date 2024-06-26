<script lang="ts">
  import { page } from '$app/stores'
  import { goto } from '$app/navigation'

  import { findUser, updateUser } from '$lib/queries/user'
  import { errors } from '$lib/helpers/stores'
  import Loader from '$lib/components/loader.svelte'
  import { _ } from '$lib/helpers/i18n'
  import QRCode from '$lib/components/qrcode.svelte'

  import type { User } from '$lib/types/User'

  let uuid = $derived($page.params.uuid)

  let user: User | undefined = $state()
  let code: string = $state('')

  $effect(() => {
    findUser({ uuid }, `uuid otpEnabled otpProvisioningUrl`)
      .then(res => {
        user = res.data.findUser
      })
      .catch(error => {
        errors.set(error.graphQLErrors)
      })
  })

  function submitEnable(event: SubmitEvent) {
    event.preventDefault()

    updateUser(
      {
        uuid,
        otpEnable: true,
        otpCode: code
      },
      `user { uuid otpEnabled }`
    )
      .then(res => {
        let data = res.data.updateUser
        user = data.user

        goto(`/users/${uuid}`)
      })
      .catch(error => {
        errors.set(error.graphQLErrors)
      })
  }

  function submitDisable(event: SubmitEvent) {
    event.preventDefault()

    updateUser(
      {
        uuid,
        otpEnable: false,
        otpCode: code
      },
      `user { uuid otpEnabled }`
    )
      .then(res => {
        let data = res.data.updateUser
        user = data.user

        goto(`/users/${uuid}`)
      })
      .catch(error => {
        errors.set(error.graphQLErrors)
      })
  }
</script>

<h1>
  {$_('pages.users.mfa.heading')}
</h1>

<Loader>
  {#if user}
    {#if user.otpEnabled}
      <form onsubmit={submitDisable}>
        <div class="mb-3">
          <label for="code" class="form-label">
            {$_('pages.users.mfa.code')}
          </label>
          <input
            type="text"
            class="form-control"
            id="name"
            bind:value={code}
            required
          />
        </div>

        <div class="mb-3">
          <button type="submit" class="btn btn-primary">
            {$_('pages.users.mfa.disable')}
          </button>
        </div>
      </form>
    {:else}
      <form onsubmit={submitEnable}>
        <div class="md-3">
          <QRCode content={user.otpProvisioningUrl} />
        </div>

        <div class="mb-3">
          <label for="name" class="form-label">
            {$_('pages.users.mfa.code')}
          </label>
          <input
            type="text"
            class="form-control"
            id="name"
            bind:value={code}
            required
          />
        </div>

        <div class="mb-3">
          <button type="submit" class="btn btn-primary">
            {$_('pages.users.mfa.enable')}
          </button>
        </div>
      </form>
    {/if}
  {/if}
</Loader>
