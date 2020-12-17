<script>
  import { createPost } from '@libs/queries'
  import { errors } from '@libs/stores'
  import { navigate } from 'svelte-navigator'
  import Form from './_form'

  function submit(event) {
    createPost(event.detail, `post { id }`).then(res => {
      if (res.errors) {
        errors.set(res.errors)
      } else {
        let data = res.data
        let id = data.createPost.post.id
        navigate('/posts/'+id)
      }
    })
  }
</script>

<h1>New Post</h1>

<Form on:submit={submit} />
