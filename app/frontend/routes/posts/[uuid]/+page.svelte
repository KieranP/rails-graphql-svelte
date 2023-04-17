<script lang="ts">
  import { page } from '$app/stores'
  import { goto } from '$app/navigation'

  import { findPost, watchPost, destroyPost } from '$lib/queries/post'
  import { session } from '$lib/helpers/session'
  import { errors } from '$lib/helpers/stores'
  import Loader from '$lib/components/loader.svelte'
  import Confirm from '$lib/components/confirm.svelte'
  import { _ } from '$lib/helpers/i18n'

  import type { Post } from '$lib/types/Post'

  let uuid = $page.params.uuid

  let post: Post

  const fields = `uuid title body user { uuid name }`

  findPost({ uuid }, fields)
    .then(res => {
      post = res.data.findPost
    })
    .catch(error => {
      errors.set(error.graphQLErrors)
    })

  watchPost({ uuid }, fields).subscribe(
    res => {
      if (res.data.postUpdated) post = res.data.postUpdated
    },
    err => {
      errors.set(err.graphQLErrors)
    }
  )

  function destroy() {
    destroyPost({ uuid }, `post { uuid }`)
      .then(() => {
        goto('/posts')
      })
      .catch(error => {
        errors.set(error.graphQLErrors)
      })
  }
</script>

<Loader result={post}>
  <h1>{post.title}</h1>
  <p>
    <small
      >By <a href="/users/{post.user.uuid}">
        {post.user.name}
      </a></small
    >
  </p>
  <p>{post.body}</p>

  {#if $session.user && $session.user.uuid == post.user.uuid}
    <p>
      <a href="/posts/{post.uuid}/edit" class="btn btn-outline-primary">
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
</Loader>

<Confirm on:confirm={destroy} />
