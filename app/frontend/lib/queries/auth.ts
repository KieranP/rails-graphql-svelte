import { gql, mutation } from '$lib/helpers/graphql'

import type { FetchResult } from '@apollo/client/core'
import type { User } from '$lib/types/user'

export const loginUser = async (
  variables: object,
): Promise<
  FetchResult<{
    loginUser: {
      user: Pick<User, 'uuid' | 'email' | 'name' | 'locale'>
    }
  }>
> =>
  mutation(
    gql`
      mutation loginUser(
        $email: String!
        $password: String!
        $otpCode: String
      ) {
        loginUser(
          input: { email: $email, password: $password, otpCode: $otpCode }
        ) {
          user {
            uuid
            email
            name
            locale
          }
        }
      }
    `,
    variables,
  )

export const logoutUser = async (
  variables: object = {},
): Promise<
  FetchResult<{
    logoutUser: {
      user: Pick<User, 'uuid'>
    }
  }>
> =>
  mutation(
    gql`
      mutation logoutUser {
        logoutUser(input: {}) {
          user {
            uuid
          }
        }
      }
    `,
    variables,
  )
