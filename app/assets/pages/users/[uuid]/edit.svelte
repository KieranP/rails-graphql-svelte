<script>
  import { findUser, updateUser } from '@queries/user'
  import { setSession } from '@libs/session'
  import { errors } from '@libs/stores'
  import { goto } from '@roxi/routify'
  import Loader from '@components/loader.svelte'
  import { allLocales, setLocale, _ } from '@libs/i18n'

  export let uuid

  let user
  let name
  let email
  let locale

  findUser({uuid}, `uuid name email locale`).then(res => {
    user = res.data.findUser
    name = user.name
    email = user.email
    locale = user.locale
  }).catch(error => {
    errors.set(error.graphQLErrors)
  })

  function submit() {
    updateUser(
      {uuid, name, email, locale},
      `user { uuid name email locale }`
    ).then(res => {
      let data = res.data.updateUser
      let user = data.user
      let uuid = user.uuid

      setSession(data)
      setLocale.set(user.locale)

      $goto('/users/:uuid', {uuid})
    }).catch(error => {
      errors.set(error.graphQLErrors)
    })
  }
</script>

<h1>
  {$_('pages.users.edit.heading')}
</h1>

{#if user}
  <form on:submit|preventDefault={submit}>
    <div class="mb-3">
      <label for="name" class="form-label">
        {$_('pages.users.edit.name')}
      </label>
      <input type="text" class="form-control" id="name" bind:value={name} required />
    </div>

    <div class="mb-3">
      <label for="email" class="form-label">
        {$_('pages.users.edit.email')}
      </label>
      <input type="email" class="form-control" id="email" bind:value={email} required />
    </div>

    <div class="mb-3">
      <label for="locale" class="form-label">
        {$_('pages.users.edit.locale')}
      </label>

      <select class="form-select" bind:value={locale}>
        {#each $allLocales as _locale}
          <option value={_locale} selected={_locale == locale}>
            {_locale}
          </option>
        {/each}
      </select>
    </div>

    <div class="mb-3">
      <button type="submit" class="btn btn-primary">
        {$_('common.update')}
      </button>
    </div>
  </form>
{:else}
  <Loader />
{/if}
