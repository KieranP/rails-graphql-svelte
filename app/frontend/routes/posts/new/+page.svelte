<script lang="ts">
  import { ApolloError } from '@apollo/client/core'

  import { goto } from '$app/navigation'

  import { _ } from '$lib/helpers/i18n'
  import { errors } from '$lib/helpers/stores'
  import { createPost } from '$lib/queries/post'

  import Form from '../_form.svelte'

  import type { PostSubmission } from '$lib/types/Post'

  function onsubmit(data: PostSubmission) {
    createPost(data, `post { uuid }`)
      .then((res) => {
        const uuid = res.data.createPost.post.uuid as string
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
  post={null}
  {onsubmit}
/>
