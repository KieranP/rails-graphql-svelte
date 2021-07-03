import { mutation } from '@libs/graphql'

export const loginUser = (variables:object, graphql:string) => (
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

export const logoutUser = (variables:object, graphql:string) => (
  mutation(`
    mutation {
      logoutUser(input: {}) {
        ${graphql}
      }
    }
  `, variables)
)
