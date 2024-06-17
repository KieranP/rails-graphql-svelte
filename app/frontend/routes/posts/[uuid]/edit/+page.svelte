<script lang="ts">
  import { page } from '$app/stores'
  import { goto } from '$app/navigation'

  import { findPost, updatePost } from '$lib/queries/post'
  import { errors } from '$lib/helpers/stores'
  import Loader from '$lib/components/loader.svelte'
  import Form from '../../_form.svelte'
  import { _ } from '$lib/helpers/i18n'

  import type { Post, PostSubmission } from '$lib/types/Post'

  let uuid = $derived($page.params.uuid)

  let post: Post | undefined = $state()

  $effect(() => {
    findPost({ uuid }, `uuid title body`)
      .then(res => {
        post = res.data.findPost
      })
      .catch(error => {
        errors.set(error.graphQLErrors)
      })
  })

  function onsubmit(data: PostSubmission) {
    updatePost({ uuid, ...data }, `post { uuid title body }`)
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

<Loader>
  {#if post}
    <Form {post} {onsubmit} />
  {/if}
</Loader>
