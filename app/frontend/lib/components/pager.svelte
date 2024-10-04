<script lang="ts">
  import { goto } from '$app/navigation'

  import { _ } from '$lib/helpers/i18n'

  import type { PageInfo } from '$lib/types/PageInfo'

  interface Props {
    pageInfo: PageInfo
  }

  const { pageInfo }: Props = $props()

  function prev() {
    const queryParams = new URLSearchParams(window.location.search)
    queryParams.set('before', pageInfo.startCursor)
    queryParams.delete('after')

    void goto(`${window.location.pathname}?${queryParams.toString()}`)
  }

  function next() {
    const queryParams = new URLSearchParams(window.location.search)
    queryParams.set('after', pageInfo.endCursor)
    queryParams.delete('before')

    void goto(`${window.location.pathname}?${queryParams.toString()}`)
  }
</script>

{#if pageInfo.hasPreviousPage}
  <button
    onclick={prev}
    class="btn btn-outline-secondary btn-sm"
  >
    {$_('components.pager.prev')}
  </button>
{/if}

{#if pageInfo.hasNextPage}
  <button
    onclick={next}
    class="btn btn-outline-secondary btn-sm"
  >
    {$_('components.pager.next')}
  </button>
{/if}
