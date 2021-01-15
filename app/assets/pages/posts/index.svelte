<script>
  import { allPosts } from '@libs/queries'
  import { session } from '@libs/session'
  import { errors } from '@libs/stores'
  import Loader from '@components/loader.svelte'
  import { url, params } from '@roxi/routify'
  import Pager from '@components/pager.svelte'
  import pager from '@libs/pager'
  import { _ } from '@libs/i18n'

  let posts
  let pageInfo

  $: allPosts(
    pager($params),
    `nodes { id title user { id name } }`
  ).then(res => {
    posts = res.data.allPosts.nodes
    pageInfo = res.data.allPosts.pageInfo
  }).catch(error => {
    errors.set(error.graphQLErrors)
  })
</script>

<h1>
  {$_('pages.posts.index.heading')}
</h1>

{#if $session.user}
  <a href={$url('/posts/new')} class="btn btn-outline-primary">
    {$_('pages.posts.index.create')}
  </a>
{/if}

{#if posts}
  <ul>
    {#each posts as post (post.id)}
      <li>
        <a href={$url('/posts/:id', { id: post.id })}>
          {post.title}
        </a>
        by
        <a href={$url('/users/:id', { id: post.user.id })}>
          {post.user.name}
        </a>
      </li>
    {/each}
  </ul>

  <Pager pageInfo={pageInfo} />
{:else}
  <Loader />
{/if}
