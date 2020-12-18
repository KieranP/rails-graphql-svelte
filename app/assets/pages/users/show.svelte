<script>
  import { findUser } from '@libs/queries'
  import { session, errors } from '@libs/stores'
  import { Link } from 'svelte-navigator'
  import Loader from '@components/loader'

  export let id

  let user

  findUser({id}, `id name email posts { id title }`).then(res => {
    if (res.errors) {
      errors.set(res.errors)
    } else {
      user = res.data.findUser
    }
  })
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
      <Link to="/users/{user.id}/edit" class="btn btn-outline-primary">Edit</Link>
    </p>
  {/if}
{:else}
  <Loader />
{/if}
