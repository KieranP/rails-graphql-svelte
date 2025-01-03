<script lang="ts">
  import { page } from '$app/stores'

  import { _ } from '$lib/helpers/i18n'
  import { session } from '$lib/helpers/session'
</script>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <div class="container-fluid">
    <ul class="navbar-nav me-auto">
      <li class="nav-item">
        <a
          class="nav-link"
          class:active={$page.url.pathname === '/index'}
          href="/"
        >
          {$_('components.nav.home')}
        </a>
      </li>

      <li class="nav-item">
        <a
          class="nav-link"
          class:active={$page.url.pathname === '/about'}
          href="/about"
        >
          {$_('components.nav.about')}
        </a>
      </li>

      <li class="nav-item">
        <a
          class="nav-link"
          class:active={$page.url.pathname === '/posts'}
          href="/posts"
        >
          {$_('components.nav.posts')}
        </a>
      </li>
    </ul>

    <ul class="navbar-nav">
      {#if $session.user}
        <li class="nav-item">
          <a
            class="nav-link"
            class:active={$page.url.pathname === '/users'}
            href="/users/{$session.user.uuid}"
          >
            {$session.user.name}
          </a>
        </li>

        <li class="nav-item">
          <a
            class="nav-link"
            href="/logout"
          >
            {$_('components.nav.logout')}
          </a>
        </li>
      {:else}
        <li class="nav-item">
          <a
            class="nav-link"
            class:active={$page.url.pathname === '/login'}
            href="/login"
          >
            {$_('components.nav.login')}
          </a>
        </li>

        <li class="nav-item">
          <a
            class="nav-link"
            class:active={$page.url.pathname === '/users/new'}
            href="/users/new"
          >
            {$_('components.nav.signup')}
          </a>
        </li>
      {/if}
    </ul>
  </div>
</nav>
