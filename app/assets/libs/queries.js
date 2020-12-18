import request from '@libs/graphql'

export let loginUser = (data, fields) => (
  request(`
    mutation($email: String!, $password: String!) {
      loginUser(input: {
        email: $email,
        password: $password
      }) {
        ${fields}
      }
    }
  `, data)
)

export let logoutUser = (data, fields) => (
  request(`
    mutation {
      logoutUser(input: {}) {
        ${fields}
      }
    }
  `, data)
)

export let findUser = (data, fields) => (
  request(`
    query($id: ID!) {
      findUser(id: $id) {
        ${fields}
      }
    }
  `, data)
)

export let updateUser = (data, fields) => (
  request(`
    mutation($id: ID!, $name: String, $email: String) {
      updateUser(input: {
        id: $id,
        name: $name,
        email: $email
      }) {
        ${fields}
      }
    }
  `, data)
)

export let allPosts = (data, fields) => (
  request(`
    query($before: String, $after: String, $first: Int, $last: Int) {
      allPosts(before: $before, after: $after, first: $first, last: $last) {
        pageInfo {
          startCursor
          endCursor
          hasPreviousPage
          hasNextPage
        }
        ${fields}
      }
    }
  `, data)
)

export let findPost = (data, fields) => (
  request(`
    query($id: ID!) {
      findPost(id: $id) {
        ${fields}
      }
    }
  `, data)
)

export let createPost = (data, fields) => (
  request(`
    mutation($title: String, $body: String) {
      createPost(input: {
        title: $title,
        body: $body
      }) {
        ${fields}
      }
    }
  `, data)
)

export let updatePost = (data, fields) => (
  request(`
    mutation($id: ID!, $title: String, $body: String) {
      updatePost(input: {
        id: $id,
        title: $title,
        body: $body
      }) {
        ${fields}
      }
    }
  `, data)
)

export let destroyPost = (data, fields) => (
  request(`
    mutation($id: ID!) {
      destroyPost(input: {
        id: $id
      }) {
        ${fields}
      }
    }
  `, data)
)
