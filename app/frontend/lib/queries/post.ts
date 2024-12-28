import { gql, mutation, query, subscribe } from '$lib/helpers/graphql'

import type {
  ApolloQueryResult,
  FetchResult,
  Observable,
} from '@apollo/client/core'
import type { PageInfo } from '$lib/types/page_info'
import type { Post } from '$lib/types/post'

export const allPosts = async (
  variables: object,
): Promise<
  ApolloQueryResult<{
    allPosts: {
      pageInfo: PageInfo
      nodes: Post[]
    }
  }>
> =>
  query(
    gql`
      query allPosts($before: String, $after: String, $first: Int, $last: Int) {
        allPosts(before: $before, after: $after, first: $first, last: $last) {
          pageInfo {
            startCursor
            endCursor
            hasPreviousPage
            hasNextPage
          }
          nodes {
            uuid
            title
            user {
              uuid
              name
            }
          }
        }
      }
    `,
    variables,
  )

export const findPost = async (
  variables: object,
  graphql: string,
): Promise<
  ApolloQueryResult<{
    findPost: Post
  }>
> =>
  query(
    gql`
      query findPost($uuid: ID!) {
        findPost(uuid: $uuid) {
          ${graphql}
        }
      }
    `,
    variables,
  )

export const watchPost = (
  variables: object,
  graphql: string,
): Observable<
  FetchResult<{
    postUpdated: Post
  }>
> =>
  subscribe(
    gql`
      subscription watchPost($uuid: ID!) {
        postUpdated(uuid: $uuid) {
          ${graphql}
        }
      }
    `,
    variables,
  )

export const createPost = async (
  variables: object,
): Promise<
  FetchResult<{
    createPost: {
      post: Pick<Post, 'uuid'>
    }
  }>
> =>
  mutation(
    gql`
      mutation createPost($title: String!, $body: String!) {
        createPost(input: { title: $title, body: $body }) {
          post {
            uuid
          }
        }
      }
    `,
    variables,
  )

export const updatePost = async (
  variables: object,
): Promise<
  FetchResult<{
    updatePost: {
      post: Pick<Post, 'uuid'>
    }
  }>
> =>
  mutation(
    gql`
      mutation updatePost($uuid: ID!, $title: String!, $body: String!) {
        updatePost(input: { uuid: $uuid, title: $title, body: $body }) {
          post {
            uuid
          }
        }
      }
    `,
    variables,
  )

export const destroyPost = async (
  variables: object,
): Promise<
  FetchResult<{
    destroyPost: {
      post: Pick<Post, 'uuid'>
    }
  }>
> =>
  mutation(
    gql`
      mutation destroyPost($uuid: ID!) {
        destroyPost(input: { uuid: $uuid }) {
          post {
            uuid
          }
        }
      }
    `,
    variables,
  )
