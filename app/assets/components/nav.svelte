<script>
  import { session } from '@libs/stores'
  import { Link } from 'svelte-navigator'
  import { _ } from '@libs/i18n'
</script>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <div class="container-fluid">
    <ul class="navbar-nav me-auto">
      <li class="nav-item">
        <Link to="/" class="nav-link">
          {$_('components.nav.home')}
        </Link>
      </li>

      <li class="nav-item">
        <Link to="/about" class="nav-link">
          {$_('components.nav.about')}
        </Link>
      </li>

      <li class="nav-item">
        <Link to="/posts" class="nav-link">
          {$_('components.nav.posts')}
        </Link>
      </li>
    </ul>

    <ul class="navbar-nav">
      {#if $session.user}
        <li class="nav-item">
          <Link to="/users/{$session.user.id}" class="nav-link">
            {$session.user.name}
          </Link>
        </li>

        <li class="nav-item">
          <Link to="/logout" class="nav-link">
            {$_('components.nav.logout')}
          </Link>
        </li>
      {:else}
        <li class="nav-item">
          <Link to="/login" class="nav-link">
            {$_('components.nav.login')}
          </Link>
        </li>
      {/if}
    </ul>
  </div>
</nav>
