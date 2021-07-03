<script lang="ts">
  import { session } from '@libs/session'
  import { url, isActive } from '@roxi/routify'
  import { _ } from '@libs/i18n'
</script>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <div class="container-fluid">
    <ul class="navbar-nav me-auto">
      <li class="nav-item">
        <a href={$url('/')} class="nav-link" class:active={$isActive('/index')}>
          {$_('components.nav.home')}
        </a>
      </li>

      <li class="nav-item">
        <a href={$url('/about')} class="nav-link" class:active={$isActive('/about')}>
          {$_('components.nav.about')}
        </a>
      </li>

      <li class="nav-item">
        <a href={$url('/posts')} class="nav-link" class:active={$isActive('/posts')}>
          {$_('components.nav.posts')}
        </a>
      </li>
    </ul>

    <ul class="navbar-nav">
      {#if $session.user}
        <li class="nav-item">
          <a href={$url('/users/:uuid', { uuid: $session.user.uuid })} class="nav-link" class:active={$isActive('/users')}>
            {$session.user.name}
          </a>
        </li>

        <li class="nav-item">
          <a href={$url('/logout')} class="nav-link">
            {$_('components.nav.logout')}
          </a>
        </li>
      {:else}
        <li class="nav-item">
          <a href={$url('/login')} class="nav-link" class:active={$isActive('/login')}>
            {$_('components.nav.login')}
          </a>
        </li>

        <li class="nav-item">
          <a href={$url('/users/new')} class="nav-link" class:active={$isActive('/users/new')}>
            {$_('components.nav.signup')}
          </a>
        </li>
      {/if}
    </ul>
  </div>
</nav>
