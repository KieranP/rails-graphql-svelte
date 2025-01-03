<script lang="ts">
  import { goto } from '$app/navigation'

  import { _ } from '$lib/helpers/i18n'

  import type { PageInfo } from '$lib/types/page_info'

  interface Props {
    pageInfo: PageInfo
  }

  const { pageInfo }: Props = $props()

  function prev(): void {
    const queryParams = new URLSearchParams(window.location.search)
    queryParams.set('before', pageInfo.startCursor)
    queryParams.delete('after')

    void goto(`${window.location.pathname}?${queryParams.toString()}`)
  }

  function next(): void {
    const queryParams = new URLSearchParams(window.location.search)
    queryParams.set('after', pageInfo.endCursor)
    queryParams.delete('before')

    void goto(`${window.location.pathname}?${queryParams.toString()}`)
  }
</script>

{#if pageInfo.hasPreviousPage}
  <button
    class="btn btn-outline-secondary btn-sm"
    onclick={prev}
    type="button"
  >
    {$_('components.pager.prev')}
  </button>
{/if}

{#if pageInfo.hasNextPage}
  <button
    class="btn btn-outline-secondary btn-sm"
    onclick={next}
    type="button"
  >
    {$_('components.pager.next')}
  </button>
{/if}
