import { gql, mutation } from '~/libs/graphql'

export const loginUser = (variables: object, graphql: string) =>
  mutation(
    gql`
    mutation loginUser($email: String!, $password: String!, $otpCode: String) {
      loginUser(input: {
        email: $email,
        password: $password,
        otpCode: $otpCode
      }) {
        ${graphql}
      }
    }
    `,
    variables
  )

export const logoutUser = (variables: object, graphql: string) =>
  mutation(
    gql`
    mutation logoutUser() {
      logoutUser(input: {}) {
        ${graphql}
      }
    }
    `,
    variables
  )
