<script lang="ts">
  import { ApolloError } from '@apollo/client/core'

  import { goto } from '$app/navigation'
  import { page } from '$app/stores'

  import Confirm from '$lib/components/confirm.svelte'
  import Loader from '$lib/components/loader.svelte'
  import { _ } from '$lib/helpers/i18n'
  import { session } from '$lib/helpers/session'
  import { errors } from '$lib/helpers/stores'
  import { destroyPost, findPost, watchPost } from '$lib/queries/post'

  import type { Post } from '$lib/types/Post'

  const uuid = $derived($page.params.uuid)

  let post: Post | undefined = $state()

  const fields = `uuid title body user { uuid name }`

  $effect(() => {
    findPost({ uuid }, fields)
      .then(res => {
        post = res.data.findPost
      })
      .catch((error: unknown) => {
        if (error instanceof ApolloError) {
          errors.set(error.graphQLErrors)
        }
      })

    watchPost({ uuid }, fields).subscribe(
      res => {
        console.log(res)
        if (res.data.postUpdated !== undefined) {
          console.log(res.data)
          console.log(res.data.postUpdated)
          post = res.data.postUpdated
        }
      },
      (error: unknown) => {
        if (error instanceof ApolloError) {
          errors.set(error.graphQLErrors)
        }
      }
    )
  })

  function destroy() {
    destroyPost({ uuid }, `post { uuid }`)
      .then(() => {
        void goto('/posts')
      })
      .catch((error: unknown) => {
        if (error instanceof ApolloError) {
          errors.set(error.graphQLErrors)
        }
      })
  }
</script>

<Loader>
  {#if post}
    <h1>{post.title}</h1>
    <p>
      <small
        >By <a href="/users/{post.user.uuid}">
          {post.user.name}
        </a></small
      >
    </p>
    <p>{post.body}</p>

    {#if $session.user?.uuid === post.user.uuid}
      <p>
        <a
          href="/posts/{post.uuid}/edit"
          class="btn btn-outline-primary"
        >
          {$_('common.edit')}
        </a>

        <button
          type="button"
          class="btn btn-outline-danger"
          data-bs-toggle="modal"
          data-bs-target="#confirmDialog"
        >
          {$_('common.delete')}
        </button>
      </p>
    {/if}
  {/if}
</Loader>

<Confirm onconfirm={destroy} />
