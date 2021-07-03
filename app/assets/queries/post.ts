import { query, mutation, subscribe } from '@libs/graphql'

export const allPosts = (variables:object, graphql:string) => (
  query(`
    query($before: String, $after: String, $first: Int, $last: Int) {
      allPosts(before: $before, after: $after, first: $first, last: $last) {
        pageInfo {
          startCursor
          endCursor
          hasPreviousPage
          hasNextPage
        }
        ${graphql}
      }
    }
  `, variables)
)

export const findPost = (variables:object, graphql:string) => (
  query(`
    query($uuid: ID!) {
      findPost(uuid: $uuid) {
        ${graphql}
      }
    }
  `, variables)
)

export const watchPost = (variables:object, graphql:string) => (
  subscribe(`
    subscription($uuid: ID!) {
      postUpdated(uuid: $uuid) {
        ${graphql}
      }
    }
  `, variables)
)

export const createPost = (variables:object, graphql:string) => (
  mutation(`
    mutation($title: String!, $body: String!) {
      createPost(input: {
        title: $title,
        body: $body
      }) {
        ${graphql}
      }
    }
  `, variables)
)

export const updatePost = (variables:object, graphql:string) => (
  mutation(`
    mutation($uuid: ID!, $title: String!, $body: String!) {
      updatePost(input: {
        uuid: $uuid,
        title: $title,
        body: $body
      }) {
        ${graphql}
      }
    }
  `, variables)
)

export const destroyPost = (variables:object, graphql:string) => (
  mutation(`
    mutation($uuid: ID!) {
      destroyPost(input: {
        uuid: $uuid
      }) {
        ${graphql}
      }
    }
  `, variables)
)
