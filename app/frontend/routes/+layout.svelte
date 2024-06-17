<script lang="ts">
  import 'bootstrap/dist/css/bootstrap.css'

  import Nav from '$lib/components/nav.svelte'
  import Errors from '$lib/components/errors.svelte'

  import type { Snippet } from 'svelte'

  interface Props {
    children: Snippet
  }

  let { children }: Props = $props()
</script>

<div class="container">
  <Nav />

  <main class="p-3">
    <Errors />

    {@render children()}
  </main>
</div>
