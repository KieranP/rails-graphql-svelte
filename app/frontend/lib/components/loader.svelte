<script lang="ts">
  import { _ } from '$lib/helpers/i18n'

  import type { Snippet } from 'svelte'

  interface Props {
    children: Snippet
  }

  const { children }: Props = $props()
</script>

{#if children}
  {@render children()}
{:else}
  <div
    class="spinner-border"
    role="status"
  >
    <span class="visually-hidden">
      {$_('components.loader.loading')}
    </span>
  </div>
{/if}
