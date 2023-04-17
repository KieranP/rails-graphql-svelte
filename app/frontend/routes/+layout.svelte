<script lang="ts">
  import 'bootstrap/dist/css/bootstrap.css'

  import Nav from '$lib/components/nav.svelte'
  import Errors from '$lib/components/errors.svelte'
</script>

<div class="container">
  <Nav />

  <main class="p-3">
    <Errors />

    <slot />
  </main>
</div>
