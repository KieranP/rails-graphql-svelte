<script lang="ts">
  import { allPosts } from '@queries/post'
  import { session } from '@libs/session'
  import { errors } from '@libs/stores'
  import Loader from '@components/loader.svelte'
  import { url, params } from '@roxi/routify'
  import Pager from '@components/pager.svelte'
  import pager from '@libs/pager'
  import { _ } from '@libs/i18n'

  import type { Post } from '@tstypes/Post'
  import type { PageInfo } from '@tstypes/PageInfo'

  let posts:Post[]
  let pageInfo:PageInfo

  $: allPosts(
    pager($params),
    `nodes { uuid title user { uuid name } }`
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

<Loader result={posts}>
  <ul>
    {#each posts as post (post.uuid)}
      <li>
        <a href={$url('/posts/:uuid', { uuid: post.uuid })}>
          {post.title}
        </a>
        by
        <a href={$url('/users/:uuid', { uuid: post.user.uuid })}>
          {post.user.name}
        </a>
      </li>
    {/each}
  </ul>

  <Pager pageInfo={pageInfo} />
</Loader>
