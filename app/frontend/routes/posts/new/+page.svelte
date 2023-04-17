<script lang="ts">
  import { goto } from '$app/navigation'

  import { createPost } from '$lib/queries/post'
  import { errors } from '$lib/helpers/stores'
  import Form from '../_form.svelte'
  import { _ } from '$lib/helpers/i18n'

  import type { PostSubmission } from '$lib/types/Post'

  function submit(event: CustomEvent<PostSubmission>) {
    createPost(event.detail, `post { uuid }`)
      .then(res => {
        let data = res.data
        let uuid = data.createPost.post.uuid
        goto(`/posts/${uuid}`)
      })
      .catch(error => {
        errors.set(error.graphQLErrors)
      })
  }
</script>

<h1>
  {$_('pages.posts.new.heading')}
</h1>

<Form post={null} on:submit={submit} />
