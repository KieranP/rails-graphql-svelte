<script>
  import { findUser, watchUser } from '@libs/queries'
  import { session, errors } from '@libs/stores'
  import { url } from '@roxi/routify'
  import Loader from '@components/loader'
  import { _ } from '@libs/i18n'

  export let id

  let user
  const fields = `id name email posts { id title }`

  findUser({id}, fields).then(res => {
    user = res.data.findUser
  }).catch(error => {
    errors.set(error.graphQLErrors)
  })

  watchUser({id}, fields).subscribe(
    (res) => { if(res.data.userUpdated) user = res.data.userUpdated },
    (err) => { errors.set(err.graphQLErrors) }
  )
</script>

{#if user}
  <h1>{user.name}</h1>
  <p>{user.email}</p>

  {#if user.posts}
    <ul>
      {#each user.posts as post (post.id)}
        <li>
          <a href={$url('/posts/:id', { id: post.id })}>
            {post.title}
          </a>
        </li>
      {/each}
    </ul>
  {/if}

  {#if $session.user && $session.user.id == user.id}
    <p>
      <a href={$url('/users/:id/edit', { id: user.id })} class="btn btn-outline-primary">
        {$_('common.edit')}
      </a>
    </p>
  {/if}
{:else}
  <Loader />
{/if}
