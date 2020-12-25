<script>
  import { findPost, updatePost } from '@libs/queries'
  import { errors } from '@libs/stores'
  import { navigate } from 'svelte-navigator'
  import Loader from '@components/loader'
  import Form from './_form'
  import { _ } from '@libs/i18n'

  export let id

  let post

  findPost({id}, `id title body`).then(res => {
    post = res.data.findPost
  }).catch(error => {
    errors.set(error.graphQLErrors)
  })

  function submit(event) {
    updatePost(
      {id, ...event.detail},
      `post { id title body }`
    ).then(res => {
      let data = res.data
      let id = data.updatePost.post.id
      navigate('/posts/'+id)
    }).catch(error => {
      errors.set(error.graphQLErrors)
    })
  }
</script>

<h1>
  {$_('pages.posts.edit.heading')}
</h1>

{#if post}
  <Form post={post} on:submit={submit} />
{:else}
  <Loader />
{/if}
