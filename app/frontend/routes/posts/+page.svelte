<script lang="ts">
  import { ApolloError } from '@apollo/client/core'

  import { page } from '$app/stores'

  import Loader from '$lib/components/loader.svelte'
  import Pager from '$lib/components/pager.svelte'
  import { _ } from '$lib/helpers/i18n'
  import pager from '$lib/helpers/pager'
  import { session } from '$lib/helpers/session'
  import { errors } from '$lib/helpers/stores'
  import { allPosts } from '$lib/queries/post'

  import type { PageInfo } from '$lib/types/page_info'
  import type { Post } from '$lib/types/post'

  const params = $derived(pager($page.url.searchParams))

  let posts: Post[] | undefined = $state()
  let pageInfo: PageInfo | undefined = $state()

  $effect(() => {
    allPosts(params)
      .then((res) => {
        posts = res.data.allPosts.nodes
        pageInfo = res.data.allPosts.pageInfo
      })
      .catch((error: unknown) => {
        if (error instanceof ApolloError) {
          errors.set(error.graphQLErrors)
        }
      })
  })
</script>

<h1>
  {$_('pages.posts.index.heading')}
</h1>

{#if $session.user}
  <a
    class="btn btn-outline-primary"
    href="/posts/new"
  >
    {$_('pages.posts.index.create')}
  </a>
{/if}

<Loader>
  {#if posts}
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

    {#if pageInfo}
      <Pager {pageInfo} />
    {/if}
  {/if}
</Loader>
