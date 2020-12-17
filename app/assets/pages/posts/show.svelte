<script>
  import { findPost, destroyPost } from '@libs/queries'
  import { session, errors } from '@libs/stores'
  import { Link, navigate } from 'svelte-navigator'
  import Loader from '@components/loader'
  import Confirm from '@components/confirm'

  export let id

  let post

  findPost({id}, `id title body user { id }`).then(res => {
    post = res.data.findPost
  })

  function destroy() {
    destroyPost({id}, `post { id }`).then(res => {
      if (res.errors) {
        errors.set(res.errors)
      } else {
        navigate('/posts')
      }
    })
  }
</script>

{#if post}
  <h1>{post.title}</h1>
  <p>{post.body}</p>

  {#if $session.user && $session.user.id == post.user.id}
    <p>
      <Link to="/posts/{post.id}/edit" class="btn btn-outline-primary">Edit</Link>
      <button type="button" class="btn btn-outline-danger" data-bs-toggle="modal" data-bs-target="#confirmDialog">Delete</button>
    </p>
  {/if}
{:else}
  <Loader />
{/if}

<Confirm on:confirm={destroy} />
