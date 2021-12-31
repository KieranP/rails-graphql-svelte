<script lang="ts">
  import Nav from '~/components/nav.svelte'
  import Errors from '~/components/errors.svelte'
</script>

<div class="container">
  <Nav />

  <main class="p-3">
    <Errors />

    <slot />
  </main>
</div>
