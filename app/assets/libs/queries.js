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
    query($id: ID!) {
      findUser(id: $id) {
        ${graphql}
      }
    }
  `, variables)
)

export const watchUser = (variables, graphql) => (
  subscribe(`
    subscription($id: ID!) {
      userUpdated(id: $id) {
        ${graphql}
      }
    }
  `, variables)
)

export const updateUser = (variables, graphql) => (
  mutation(`
    mutation($id: ID!, $name: String, $email: String) {
      updateUser(input: {
        id: $id,
        name: $name,
        email: $email
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
    query($id: ID!) {
      findPost(id: $id) {
        ${graphql}
      }
    }
  `, variables)
)

export const watchPost = (variables, graphql) => (
  subscribe(`
    subscription($id: ID!) {
      postUpdated(id: $id) {
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
    mutation($id: ID!, $title: String, $body: String) {
      updatePost(input: {
        id: $id,
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
    mutation($id: ID!) {
      destroyPost(input: {
        id: $id
      }) {
        ${graphql}
      }
    }
  `, variables)
)
