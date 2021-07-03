<script lang="ts">
  import { createPost } from '@queries/post'
  import { errors } from '@libs/stores'
  import { goto } from '@roxi/routify'
  import Form from './_form.svelte'
  import { _ } from '@libs/i18n'

  import type { PostSubmission } from '@tstypes/Post'

  function submit(event:CustomEvent<PostSubmission>) {
    createPost(event.detail, `post { uuid }`).then(res => {
      let data = res.data
      let uuid = data.createPost.post.uuid
      $goto('/posts/:uuid', {uuid})
    }).catch(error => {
      errors.set(error.graphQLErrors)
    })
  }
</script>

<h1>
  {$_('pages.posts.new.heading')}
</h1>

<Form post={null} on:submit={submit} />
