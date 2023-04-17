<script lang="ts">
  import { goto } from '$app/navigation'

  import { _ } from '$lib/helpers/i18n'

  import type { PageInfo } from '$lib/types/PageInfo'

  export let pageInfo: PageInfo

  function prev() {
    let queryParams = new URLSearchParams(window.location.search)
    queryParams.set('before', pageInfo.startCursor)
    queryParams.delete('after')

    goto(`${window.location.pathname}?${queryParams.toString()}`)
  }

  function next() {
    let queryParams = new URLSearchParams(window.location.search)
    queryParams.set('after', pageInfo.endCursor)
    queryParams.delete('before')

    goto(`${window.location.pathname}?${queryParams.toString()}`)
  }
</script>

{#if pageInfo.hasPreviousPage}
  <button on:click={prev} class="btn btn-outline-secondary btn-sm">
    {$_('components.pager.prev')}
  </button>
{/if}

{#if pageInfo.hasNextPage}
  <button on:click={next} class="btn btn-outline-secondary btn-sm">
    {$_('components.pager.next')}
  </button>
{/if}
