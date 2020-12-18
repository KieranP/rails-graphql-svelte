<script>
  import { allPosts } from '@libs/queries'
  import { session } from '@libs/stores'
  import Loader from '@components/loader'
  import { Link } from 'svelte-navigator'

  let posts

  allPosts({}, `id title user { id name }`).then(res => {
    posts = res.data.allPosts
  })
</script>

<h1>All Posts</h1>

{#if $session.user}
  <Link to="/posts/new" class="btn btn-outline-primary">New Post</Link>
{/if}

{#if posts}
  <ul>
    {#each posts as post (post.id)}
      <li>
        <Link to="/posts/{post.id}">
          {post.title}
        </Link>
        by
        <Link to="/users/{post.user.id}">
          {post.user.name}
        </Link>
      </li>
    {/each}
  </ul>
{:else}
  <Loader />
{/if}
