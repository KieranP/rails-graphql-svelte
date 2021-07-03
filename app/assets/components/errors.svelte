<script lang="ts">
  import { beforeUrlChange } from '@roxi/routify'
  import { errors } from '@libs/stores'

  // Clear errors when page location changes
  $beforeUrlChange((_event:any, _store:any) => {
    errors.set([])
    return true
  })
</script>

{#if $errors && $errors.length}
  {#each $errors as error}
    <div class="alert alert-danger" role="alert">
      {error.message}
    </div>
  {/each}
{/if}
