<script lang="ts">
  import { createEventDispatcher } from 'svelte'
  import { _ } from '~/libs/i18n'

  import type { Post } from '~/types/Post'

  const dispatch = createEventDispatcher()
  const submit = () => dispatch('submit', { title, body })

  export let post: Post | null
  let title = post?.title
  let body = post?.body
</script>

<form on:submit|preventDefault={submit}>
  <div class="mb-3">
    <label for="title" class="form-label">
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
    <label for="body" class="form-label">
      {$_('pages.posts._form.body')}
    </label>
    <textarea
      class="form-control"
      id="body"
      rows="5"
      bind:value={body}
      required
    />
  </div>

  <div class="mb-3">
    <button type="submit" class="btn btn-primary">
      {#if post}
        {$_('common.update')}
      {:else}
        {$_('common.create')}
      {/if}
    </button>
  </div>
</form>
