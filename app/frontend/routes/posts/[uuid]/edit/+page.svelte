<script lang="ts">
  import { page } from '$app/stores'
  import { goto } from '$app/navigation'

  import { findPost, updatePost } from '$lib/queries/post'
  import { errors } from '$lib/helpers/stores'
  import Loader from '$lib/components/loader.svelte'
  import Form from '../../_form.svelte'
  import { _ } from '$lib/helpers/i18n'

  import type { Post, PostSubmission } from '$lib/types/Post'

  let uuid = $page.params.uuid

  let post: Post

  findPost({ uuid }, `uuid title body`)
    .then(res => {
      post = res.data.findPost
    })
    .catch(error => {
      errors.set(error.graphQLErrors)
    })

  function submit(event: CustomEvent<PostSubmission>) {
    updatePost({ uuid, ...event.detail }, `post { uuid title body }`)
      .then(res => {
        let data = res.data
        let uuid = data.updatePost.post.uuid
        goto(`/posts/${uuid}`)
      })
      .catch(error => {
        errors.set(error.graphQLErrors)
      })
  }
</script>

<h1>
  {$_('pages.posts.edit.heading')}
</h1>

<Loader result={post}>
  <Form {post} on:submit={submit} />
</Loader>
