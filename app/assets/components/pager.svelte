<script>
  import { navigate } from 'svelte-navigator'

  export let pageInfo

  function prev() {
    let queryParams = new URLSearchParams(window.location.search)
    queryParams.set('before', pageInfo.startCursor)
    queryParams.delete('after')
    navigate(`${window.location.pathname}?${queryParams.toString()}`)
  }

  function next() {
    let queryParams = new URLSearchParams(window.location.search)
    queryParams.set('after', pageInfo.endCursor)
    queryParams.delete('before')
    navigate(`${window.location.pathname}?${queryParams.toString()}`)
  }
</script>

{#if pageInfo.hasPreviousPage}
  <button on:click={prev} class="btn btn-outline-secondary btn-sm">Prev</button>
{/if}

{#if pageInfo.hasNextPage}
  <button on:click={next} class="btn btn-outline-secondary btn-sm">Next</button>
{/if}
