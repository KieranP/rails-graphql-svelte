<script lang="ts">
  import { _ } from '@libs/i18n'

  export let result: any
</script>

{#if result}
  <slot />
{:else}
  <div class="spinner-border" role="status">
    <span class="visually-hidden">
      {$_('components.loader.loading')}
    </span>
  </div>
{/if}
