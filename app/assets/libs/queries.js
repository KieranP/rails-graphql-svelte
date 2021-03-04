import { query, mutation, subscribe } from '@libs/graphql'

export const loginUser = (variables, graphql) => (
  mutation(`
    mutation($email: String!, $password: String!) {
      loginUser(input: {
        email: $email,
        password: $password
      }) {
        ${graphql}
      }
    }
  `, variables)
)

export const logoutUser = (variables, graphql) => (
  mutation(`
    mutation {
      logoutUser(input: {}) {
        ${graphql}
      }
    }
  `, variables)
)

export const findUser = (variables, graphql) => (
  query(`
    query($uuid: ID!) {
      findUser(uuid: $uuid) {
        ${graphql}
      }
    }
  `, variables)
)

export const watchUser = (variables, graphql) => (
  subscribe(`
    subscription($uuid: ID!) {
      userUpdated(uuid: $uuid) {
        ${graphql}
      }
    }
  `, variables)
)

export const updateUser = (variables, graphql) => (
  mutation(`
    mutation($uuid: ID!, $name: String, $email: String, $locale: String) {
      updateUser(input: {
        uuid: $uuid,
        name: $name,
        email: $email,
        locale: $locale
      }) {
        ${graphql}
      }
    }
  `, variables)
)

export const allPosts = (variables, graphql) => (
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

export const findPost = (variables, graphql) => (
  query(`
    query($uuid: ID!) {
      findPost(uuid: $uuid) {
        ${graphql}
      }
    }
  `, variables)
)

export const watchPost = (variables, graphql) => (
  subscribe(`
    subscription($uuid: ID!) {
      postUpdated(uuid: $uuid) {
        ${graphql}
      }
    }
  `, variables)
)

export const createPost = (variables, graphql) => (
  mutation(`
    mutation($title: String, $body: String) {
      createPost(input: {
        title: $title,
        body: $body
      }) {
        ${graphql}
      }
    }
  `, variables)
)

export const updatePost = (variables, graphql) => (
  mutation(`
    mutation($uuid: ID!, $title: String, $body: String) {
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

export const destroyPost = (variables, graphql) => (
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
