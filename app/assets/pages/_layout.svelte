<script>
  import Nav from '@components/nav'
  import Errors from '@components/errors'
</script>

<div class="container">
  <Nav />

  <main class="p-3">
    <Errors />

    <slot />
  </main>
</div>
