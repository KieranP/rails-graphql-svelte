<script>
  import { session } from '../libs/stores'
  import { Link } from 'svelte-navigator'
</script>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <div class="container-fluid">
    <ul class="navbar-nav me-auto">
      <li class="nav-item">
        <Link to="/" class="nav-link">Home</Link>
      </li>

      <li class="nav-item">
        <Link to="/about" class="nav-link">About</Link>
      </li>

      <li class="nav-item">
        <Link to="/posts" class="nav-link">Posts</Link>
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
          <Link to="/logout" class="nav-link">Logout</Link>
        </li>
      {:else}
        <li class="nav-item">
          <Link to="/login" class="nav-link">Login</Link>
        </li>
      {/if}
    </ul>
  </div>
</nav>
