<script>
  import { allPosts } from '@libs/queries'
  import { session } from '@libs/stores'
  import Loader from '@components/loader'
  import { Link, useLocation } from 'svelte-navigator'
  import Pager from '@components/pager'
  import pager from '@libs/pager'

  let posts
  let pageInfo

  const location = useLocation()
  $: allPosts(
    pager($location),
    `nodes { id title user { id name } }`
  ).then(res => {
    posts = res.data.allPosts.nodes
    pageInfo = res.data.allPosts.pageInfo
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

  <Pager pageInfo={pageInfo} />
{:else}
  <Loader />
{/if}
