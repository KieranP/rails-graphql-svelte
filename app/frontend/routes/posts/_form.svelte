<script lang="ts">
  import { _ } from '$lib/helpers/i18n'

  import type { Post, PostSubmission } from '$lib/types/post'

  interface Props {
    post: Post | null
    onsubmit: (data: PostSubmission) => void
  }

  const { post, onsubmit }: Props = $props()

  let title = $state(post?.title)
  let body = $state(post?.body)

  function submit(event: SubmitEvent): void {
    event.preventDefault()
    onsubmit({ title, body })
  }
</script>

<form onsubmit={submit}>
  <div class="mb-3">
    <label
      class="form-label"
      for="title"
    >
      {$_('pages.posts._form.title')}
    </label>
    <input
      id="title"
      class="form-control"
      required
      type="text"
      bind:value={title}
    />
  </div>

  <div class="mb-3">
    <label
      class="form-label"
      for="body"
    >
      {$_('pages.posts._form.body')}
    </label>
    <textarea
      id="body"
      class="form-control"
      required
      rows="5"
      bind:value={body}
    ></textarea>
  </div>

  <div class="mb-3">
    <button
      class="btn btn-primary"
      type="submit"
    >
      {#if post}
        {$_('common.update')}
      {:else}
        {$_('common.create')}
      {/if}
    </button>
  </div>
</form>
