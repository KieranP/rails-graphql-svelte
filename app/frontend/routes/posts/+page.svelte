<script lang="ts">
  import { page } from '$app/stores'

  import { allPosts } from '$lib/queries/post'
  import { session } from '$lib/helpers/session'
  import { errors } from '$lib/helpers/stores'
  import Loader from '$lib/components/loader.svelte'
  import Pager from '$lib/components/pager.svelte'
  import pager from '$lib/helpers/pager'
  import { _ } from '$lib/helpers/i18n'

  import type { Post } from '$lib/types/Post'
  import type { PageInfo } from '$lib/types/PageInfo'

  let posts: Post[]
  let pageInfo: PageInfo

  let params = {}
  $: params = pager($page.url.searchParams)

  $: allPosts(params, `nodes { uuid title user { uuid name } }`)
    .then(res => {
      posts = res.data.allPosts.nodes
      pageInfo = res.data.allPosts.pageInfo
    })
    .catch(error => {
      errors.set(error.graphQLErrors)
    })
</script>

<h1>
  {$_('pages.posts.index.heading')}
</h1>

{#if $session.user}
  <a href="/posts/new" class="btn btn-outline-primary">
    {$_('pages.posts.index.create')}
  </a>
{/if}

<Loader loaded={!!posts}>
  <ul>
    {#each posts as post (post.uuid)}
      <li>
        <a href="/posts/{post.uuid}">
          {post.title}
        </a>
        by
        <a href="/users/{post.user.uuid}">
          {post.user.name}
        </a>
      </li>
    {/each}
  </ul>

  <Pager {pageInfo} />
</Loader>
