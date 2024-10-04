import { gql, mutation } from '$lib/helpers/graphql'

export const loginUser = async (variables: object, graphql: string) =>
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

export const logoutUser = async (variables: object, graphql: string) =>
  mutation(
    gql`
    mutation logoutUser {
      logoutUser(input: {}) {
        ${graphql}
      }
    }
    `,
    variables
  )
