<script lang="ts">
  import { ApolloError } from '@apollo/client/core'

  import { goto } from '$app/navigation'

  import { _ } from '$lib/helpers/i18n'
  import { errors } from '$lib/helpers/stores'
  import { createPost } from '$lib/queries/post'

  import Form from '../_form.svelte'

  import type { PostSubmission } from '$lib/types/post'

  function onsubmit(data: PostSubmission): void {
    createPost(data)
      .then((res) => {
        if (!res.data?.createPost) return

        const post = res.data.createPost.post
        const uuid = post.uuid
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
  {$_('pages.posts.new.heading')}
</h1>

<Form
  {onsubmit}
  post={null}
/>
