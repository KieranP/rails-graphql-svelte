<script lang="ts">
  import { beforeNavigate } from '$app/navigation'

  import { errors } from '$lib/helpers/stores'

  // Clear errors when page location changes
  beforeNavigate(() => {
    errors.set([])
    return true
  })
</script>

{#if $errors.length > 0}
  {#each $errors as error (error)}
    <div
      class="alert alert-danger"
      role="alert"
    >
      {error.message}
    </div>
  {/each}
{/if}
