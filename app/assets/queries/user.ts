import { query, mutation, subscribe } from '@libs/graphql'

export const findUser = (variables:object, graphql:string) => (
  query(`
    query($uuid: ID!) {
      findUser(uuid: $uuid) {
        ${graphql}
      }
    }
  `, variables)
)

export const watchUser = (variables:object, graphql:string) => (
  subscribe(`
    subscription($uuid: ID!) {
      userUpdated(uuid: $uuid) {
        ${graphql}
      }
    }
  `, variables)
)

export const createUser = (variables:object, graphql:string) => (
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

export const updateUser = (variables:object, graphql:string) => (
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
