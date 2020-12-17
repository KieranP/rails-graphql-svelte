<script>
  import { errors } from '@libs/stores'
  import { useLocation } from 'svelte-navigator'

  // Clear errors when page location changes
  const location = useLocation()
  $: if ($location) errors.set([])
</script>

{#if $errors.length}
  {#each $errors as error}
    <div class="alert alert-danger" role="alert">
      {error.message}
    </div>
  {/each}
{/if}
