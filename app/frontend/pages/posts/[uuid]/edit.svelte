<script lang="ts">
  import { findPost, updatePost } from '~/queries/post'
  import { errors } from '~/libs/stores'
  import { goto } from '@roxi/routify'
  import Loader from '~/components/loader.svelte'
  import Form from '../_form.svelte'
  import { _ } from '~/libs/i18n'

  import type { Post, PostSubmission } from '~/types/Post'

  export let uuid: string

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
        $goto('/posts/:uuid', { uuid })
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
