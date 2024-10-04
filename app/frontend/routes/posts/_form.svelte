<script lang="ts">
  import { _ } from '$lib/helpers/i18n'

  import type { Post, PostSubmission } from '$lib/types/Post'

  interface Props {
    post: Post | null
    onsubmit: (data: PostSubmission) => void
  }

  const { post, onsubmit }: Props = $props()

  let title = $state(post?.title)
  let body = $state(post?.body)

  function submit(event: SubmitEvent) {
    event.preventDefault()
    onsubmit({ title, body })
  }
</script>

<form onsubmit={submit}>
  <div class="mb-3">
    <label
      for="title"
      class="form-label"
    >
      {$_('pages.posts._form.title')}
    </label>
    <input
      type="text"
      class="form-control"
      id="title"
      bind:value={title}
      required
    />
  </div>

  <div class="mb-3">
    <label
      for="body"
      class="form-label"
    >
      {$_('pages.posts._form.body')}
    </label>
    <textarea
      class="form-control"
      id="body"
      rows="5"
      bind:value={body}
      required
    ></textarea>
  </div>

  <div class="mb-3">
    <button
      type="submit"
      class="btn btn-primary"
    >
      {#if post}
        {$_('common.update')}
      {:else}
        {$_('common.create')}
      {/if}
    </button>
  </div>
</form>
