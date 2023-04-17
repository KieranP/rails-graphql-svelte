import { gql, query, mutation, subscribe } from '$lib/helpers/graphql'

export const allPosts = (variables: object, graphql: string) =>
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
        ${graphql}
      }
    }
    `,
    variables
  )

export const findPost = (variables: object, graphql: string) =>
  query(
    gql`
    query findPost($uuid: ID!) {
      findPost(uuid: $uuid) {
        ${graphql}
      }
    }
    `,
    variables
  )

export const watchPost = (variables: object, graphql: string) =>
  subscribe(
    gql`
    subscription watchPost($uuid: ID!) {
      postUpdated(uuid: $uuid) {
        ${graphql}
      }
    }
    `,
    variables
  )

export const createPost = (variables: object, graphql: string) =>
  mutation(
    gql`
    mutation createPost($title: String!, $body: String!) {
      createPost(input: {
        title: $title,
        body: $body
      }) {
        ${graphql}
      }
    }
    `,
    variables
  )

export const updatePost = (variables: object, graphql: string) =>
  mutation(
    gql`
    mutation updatePost($uuid: ID!, $title: String!, $body: String!) {
      updatePost(input: {
        uuid: $uuid,
        title: $title,
        body: $body
      }) {
        ${graphql}
      }
    }
    `,
    variables
  )

export const destroyPost = (variables: object, graphql: string) =>
  mutation(
    gql`
    mutation destroyPost($uuid: ID!) {
      destroyPost(input: {
        uuid: $uuid
      }) {
        ${graphql}
      }
    }
    `,
    variables
  )
