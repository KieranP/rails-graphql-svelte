<script lang="ts">
  import { ApolloError } from '@apollo/client/core'

  import { page } from '$app/stores'

  import Loader from '$lib/components/loader.svelte'
  import { _ } from '$lib/helpers/i18n'
  import { session } from '$lib/helpers/session'
  import { errors } from '$lib/helpers/stores'
  import { findUser, watchUser } from '$lib/queries/user'

  import type { User } from '$lib/types/user'

  const uuid = $derived($page.params['uuid'])

  let user: User | undefined = $state()

  const fields = `uuid name email posts { uuid title }`

  $effect(() => {
    findUser({ uuid }, fields)
      .then((res) => {
        user = res.data.findUser
      })
      .catch((error: unknown) => {
        if (error instanceof ApolloError) {
          errors.set(error.graphQLErrors)
        }
      })

    watchUser({ uuid }, fields).subscribe(
      (res) => {
        if (!res.data?.userUpdated) return

        user = res.data.userUpdated
      },
      (error: unknown) => {
        if (error instanceof ApolloError) {
          errors.set(error.graphQLErrors)
        }
      },
    )
  })
</script>

<Loader>
  {#if user}
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

    {#if $session.user?.uuid === user.uuid}
      <p>
        <a
          class="btn btn-outline-primary"
          href="/users/{user.uuid}/edit"
        >
          {$_('common.edit')}
        </a>
      </p>
    {/if}
  {/if}
</Loader>
