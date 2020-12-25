<script>
  import { findUser, watchUser } from '@libs/queries'
  import { session, errors } from '@libs/stores'
  import { Link } from 'svelte-navigator'
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
          <Link to="/posts/{post.id}">
            {post.title}
          </Link>
        </li>
      {/each}
    </ul>
  {/if}

  {#if $session.user && $session.user.id == user.id}
    <p>
      <Link to="/users/{user.id}/edit" class="btn btn-outline-primary">
        {$_('common.edit')}
      </Link>
    </p>
  {/if}
{:else}
  <Loader />
{/if}
