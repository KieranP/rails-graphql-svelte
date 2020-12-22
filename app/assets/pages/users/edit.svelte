<script>
  import { findUser, updateUser } from '@libs/queries'
  import { errors } from '@libs/stores'
  import { navigate } from 'svelte-navigator'
  import Loader from '@components/loader'

  export let id

  let user
  let name
  let email

  findUser({id}, `id name email`).then(res => {
    user = res.data.findUser
    name = user.name
    email = user.email
  }).catch(error => {
    errors.set(error.graphQLErrors)
  })

  function submit() {
    updateUser(
      {id, name, email},
      `user { id name email }`
    ).then(res => {
      let data = res.data
      let id = data.updateUser.user.id
      navigate('/users/'+id)
    }).catch(error => {
      errors.set(error.graphQLErrors)
    })
  }
</script>

<h1>Edit User</h1>

{#if user}
  <form on:submit|preventDefault={submit}>
    <div class="mb-3">
      <label for="name" class="form-label">Name</label>
      <input type="text" class="form-control" id="name" bind:value={name} required />
    </div>

    <div class="mb-3">
      <label for="email" class="form-label">Email</label>
      <input type="email" class="form-control" id="email" bind:value={email} required />
    </div>

    <div class="mb-3">
      <button type="submit" class="btn btn-primary">
        Update
      </button>
    </div>
  </form>
{:else}
  <Loader />
{/if}
