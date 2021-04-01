<script>
  import { findUser, watchUser } from '@queries/user'
  import { session } from '@libs/session'
  import { errors } from '@libs/stores'
  import { url } from '@roxi/routify'
  import Loader from '@components/loader.svelte'
  import { _ } from '@libs/i18n'

  export let uuid

  let user
  const fields = `uuid name email posts { uuid title }`

  findUser({uuid}, fields).then(res => {
    user = res.data.findUser
  }).catch(error => {
    errors.set(error.graphQLErrors)
  })

  watchUser({uuid}, fields).subscribe(
    (res) => { if(res.data.userUpdated) user = res.data.userUpdated },
    (err) => { errors.set(err.graphQLErrors) }
  )
</script>

<Loader result={user}>
  <h1>{user.name}</h1>
  <p>{user.email}</p>

  {#if user.posts}
    <ul>
      {#each user.posts as post (post.uuid)}
        <li>
          <a href={$url('/posts/:uuid', { uuid: post.uuid })}>
            {post.title}
          </a>
        </li>
      {/each}
    </ul>
  {/if}

  {#if $session.user && $session.user.uuid == user.uuid}
    <p>
      <a href={$url('/users/:uuid/edit', { uuid: user.uuid })} class="btn btn-outline-primary">
        {$_('common.edit')}
      </a>
    </p>
  {/if}
</Loader>
