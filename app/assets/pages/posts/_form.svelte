<script>
  import { createEventDispatcher } from 'svelte'
  const dispatch = createEventDispatcher()
  const submit = () => dispatch('submit', { title, body })

  export let post
  let title = post?.title
  let body = post?.body
</script>

<form on:submit|preventDefault={submit}>
  <div class="mb-3">
    <label for="title" class="form-label">Title</label>
    <input type="text" class="form-control" id="title" bind:value={title} required />
  </div>

  <div class="mb-3">
    <label for="body" class="form-label">Body</label>
    <textarea class="form-control" id="body" rows="5" bind:value={body} required />
  </div>

  <div class="mb-3">
    <button type="submit" class="btn btn-primary">
      {#if post}
        Update
      {:else}
        Create
      {/if}
    </button>
  </div>
</form>
