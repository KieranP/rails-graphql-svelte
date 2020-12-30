<script>
  import { createPost } from '@libs/queries'
  import { errors } from '@libs/stores'
  import { goto } from '@roxi/routify'
  import Form from './_form'
  import { _ } from '@libs/i18n'

  function submit(event) {
    createPost(event.detail, `post { id }`).then(res => {
      let data = res.data
      let id = data.createPost.post.id
      $goto('/posts/:id', {id})
    }).catch(error => {
      errors.set(error.graphQLErrors)
    })
  }
</script>

<h1>
  {$_('pages.posts.new.heading')}
</h1>

<Form on:submit={submit} />
