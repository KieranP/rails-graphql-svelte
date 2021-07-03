<script lang="ts">
  import { goto } from '@roxi/routify'
  import { _ } from '@libs/i18n'

  import type { PageInfo } from '@tstypes/PageInfo'

  export let pageInfo:PageInfo

  function prev() {
    let queryParams = new URLSearchParams(window.location.search)
    queryParams.set('before', pageInfo.startCursor)
    queryParams.delete('after')

    let queryParamsObj = Object.fromEntries(queryParams.entries())
    $goto(window.location.pathname, queryParamsObj)
  }

  function next() {
    let queryParams = new URLSearchParams(window.location.search)
    queryParams.set('after', pageInfo.endCursor)
    queryParams.delete('before')

    let queryParamsObj = Object.fromEntries(queryParams.entries())
    $goto(window.location.pathname, queryParamsObj)
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
