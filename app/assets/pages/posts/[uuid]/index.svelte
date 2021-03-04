<script>
  import { findPost, watchPost, destroyPost } from '@libs/queries'
  import { session } from '@libs/session'
  import { errors } from '@libs/stores'
  import { url, goto } from '@roxi/routify'
  import Loader from '@components/loader.svelte'
  import Confirm from '@components/confirm.svelte'
  import { _ } from '@libs/i18n'

  export let uuid

  let post

  const fields = `uuid title body user { uuid }`

  findPost({uuid}, fields).then(res => {
    post = res.data.findPost
  }).catch(error => {
    errors.set(error.graphQLErrors)
  })

  watchPost({uuid}, fields).subscribe(
    (res) => { if(res.data.postUpdated) post = res.data.postUpdated },
    (err) => { errors.set(err.graphQLErrors) }
  )

  function destroy() {
    destroyPost({uuid}, `post { uuid }`).then(res => {
      $goto('/posts')
    }).catch(error => {
      errors.set(error.graphQLErrors)
    })
  }
</script>

{#if post}
  <h1>{post.title}</h1>
  <p>{post.body}</p>

  {#if $session.user && $session.user.uuid == post.user.uuid}
    <p>
      <a href={$url('/posts/:uuid/edit', { uuid: post.uuid })} class="btn btn-outline-primary">
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
