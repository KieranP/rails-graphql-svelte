<script lang="ts">
  import { ApolloError } from '@apollo/client/core'

  import { goto } from '$app/navigation'
  import { page } from '$app/stores'

  import Loader from '$lib/components/loader.svelte'
  import { _ } from '$lib/helpers/i18n'
  import { errors } from '$lib/helpers/stores'
  import { findPost, updatePost } from '$lib/queries/post'

  import Form from '../../_form.svelte'

  import type { Post, PostSubmission } from '$lib/types/post'

  const uuid = $derived($page.params['uuid'])

  let post: Post | undefined = $state()

  $effect(() => {
    findPost({ uuid }, `uuid title body`)
      .then((res) => {
        post = res.data.findPost
      })
      .catch((error: unknown) => {
        if (error instanceof ApolloError) {
          errors.set(error.graphQLErrors)
        }
      })
  })

  function onsubmit(data: PostSubmission) {
    updatePost({ uuid, ...data })
      .then((_res) => {
        void goto(`/posts/${uuid}`)
      })
      .catch((error: unknown) => {
        if (error instanceof ApolloError) {
          errors.set(error.graphQLErrors)
        }
      })
  }
</script>

<h1>
  {$_('pages.posts.edit.heading')}
</h1>

<Loader>
  {#if post}
    <Form
      {post}
      {onsubmit}
    />
  {/if}
</Loader>
