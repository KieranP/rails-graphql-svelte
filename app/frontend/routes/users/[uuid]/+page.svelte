<script lang="ts">
  import { page } from '$app/stores'

  import { findUser, watchUser } from '$lib/queries/user'
  import { session } from '$lib/helpers/session'
  import { errors } from '$lib/helpers/stores'
  import Loader from '$lib/components/loader.svelte'
  import { _ } from '$lib/helpers/i18n'

  import type { User } from '$lib/types/User'

  let uuid = $page.params.uuid

  let user: User
  const fields = `uuid name email posts { uuid title }`

  findUser({ uuid }, fields)
    .then(res => {
      user = res.data.findUser
    })
    .catch(error => {
      errors.set(error.graphQLErrors)
    })

  watchUser({ uuid }, fields).subscribe(
    res => {
      if (res.data.userUpdated) user = res.data.userUpdated
    },
    err => {
      errors.set(err.graphQLErrors)
    }
  )
</script>

<Loader result={user}>
  <h1>{user.name}</h1>
  <p>{user.email}</p>

  {#if user.posts}
    <ul>
      {#each user.posts as post (post.uuid)}
        <li>
          <a href="/posts/{post.uuid}">
            {post.title}
          </a>
        </li>
      {/each}
    </ul>
  {/if}

  {#if $session.user && $session.user.uuid == user.uuid}
    <p>
      <a href="/users/{user.uuid}/edit" class="btn btn-outline-primary">
        {$_('common.edit')}
      </a>
    </p>
  {/if}
</Loader>
