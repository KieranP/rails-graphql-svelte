<script>
  import { findPost, watchPost, destroyPost } from '@libs/queries'
  import { session, errors } from '@libs/stores'
  import { url, goto } from '@roxi/routify'
  import Loader from '@components/loader'
  import Confirm from '@components/confirm'
  import { _ } from '@libs/i18n'

  export let id

  let post

  const fields = `id title body user { id }`

  findPost({id}, fields).then(res => {
    post = res.data.findPost
  }).catch(error => {
    errors.set(error.graphQLErrors)
  })

  watchPost({id}, fields).subscribe(
    (res) => { if(res.data.postUpdated) post = res.data.postUpdated },
    (err) => { errors.set(err.graphQLErrors) }
  )

  function destroy() {
    destroyPost({id}, `post { id }`).then(res => {
      $goto('/posts')
    }).catch(error => {
      errors.set(error.graphQLErrors)
    })
  }
</script>

{#if post}
  <h1>{post.title}</h1>
  <p>{post.body}</p>

  {#if $session.user && $session.user.id == post.user.id}
    <p>
      <a href={$url('/posts/:id/edit', { id: post.id })} class="btn btn-outline-primary">
        {$_('common.edit')}
      </a>

      <button type="button" class="btn btn-outline-danger" data-bs-toggle="modal" data-bs-target="#confirmDialog">
        {$_('common.delete')}
      </button>
    </p>
  {/if}
{:else}
  <Loader />
{/if}

<Confirm on:confirm={destroy} />
