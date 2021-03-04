import { mutation } from '@libs/graphql'

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
