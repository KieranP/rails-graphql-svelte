<script>
  import { findPost, updatePost } from '@libs/queries'
  import { errors } from '@libs/stores'
  import { navigate } from 'svelte-navigator'
  import Loader from '@components/loader'
  import Form from './_form'

  export let id

  let post

  findPost({id}, `id title body`).then(res => {
    post = res.data.findPost
  })

  function submit(event) {
    updatePost({id, ...event.detail}, `post { id }`).then(res => {
      if (res.errors) {
        errors.set(res.errors)
      } else {
        let data = res.data
        let id = data.updatePost.post.id
        navigate('/posts/'+id)
      }
    })
  }
</script>

<h1>Edit Post</h1>

{#if post}
  <Form post={post} on:submit={submit} />
{:else}
  <Loader />
{/if}
