<script lang="ts">
  import { _ } from '$lib/helpers/i18n'

  export let loaded = false
</script>

{#if loaded}
  <slot />
{:else}
  <div class="spinner-border" role="status">
    <span class="visually-hidden">
      {$_('components.loader.loading')}
    </span>
  </div>
{/if}
