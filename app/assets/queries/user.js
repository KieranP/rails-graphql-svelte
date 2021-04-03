import { query, mutation, subscribe } from '@libs/graphql'

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

export const createUser = (variables, graphql) => (
  mutation(`
    mutation($email: String!, $name: String!, $locale: String!, $password: String!, $passwordConfirmation: String!) {
      createUser(input: {
        email: $email,
        name: $name,
        locale: $locale,
        password: $password,
        passwordConfirmation: $passwordConfirmation
      }) {
        ${graphql}
      }
    }
  `, variables)
)

export const updateUser = (variables, graphql) => (
  mutation(`
    mutation($uuid: ID!, $name: String!, $email: String!, $locale: String!) {
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
