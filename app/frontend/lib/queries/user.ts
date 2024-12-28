import { gql, mutation, query, subscribe } from '$lib/helpers/graphql'

import type {
  ApolloQueryResult,
  FetchResult,
  Observable,
} from '@apollo/client/core'
import type { User } from '$lib/types/user'

export const findUser = async (
  variables: object,
  graphql: string,
): Promise<
  ApolloQueryResult<{
    findUser: User
  }>
> =>
  query(
    gql`
      query findUser($uuid: ID!) {
        findUser(uuid: $uuid) {
          ${graphql}
        }
      }
    `,
    variables,
  )

export const watchUser = (
  variables: object,
  graphql: string,
): Observable<
  FetchResult<{
    userUpdated: User
  }>
> =>
  subscribe(
    gql`
      subscription watchUser($uuid: ID!) {
        userUpdated(uuid: $uuid) {
          ${graphql}
        }
      }
    `,
    variables,
  )

export const createUser = async (
  variables: object,
): Promise<
  FetchResult<{
    createUser: {
      user: Pick<User, 'uuid' | 'name' | 'email' | 'locale'>
    }
  }>
> =>
  mutation(
    gql`
      mutation createUser(
        $email: String!
        $name: String!
        $locale: String!
        $password: String!
        $passwordConfirmation: String!
      ) {
        createUser(
          input: {
            email: $email
            name: $name
            locale: $locale
            password: $password
            passwordConfirmation: $passwordConfirmation
          }
        ) {
          user {
            uuid
            name
            email
            locale
          }
        }
      }
    `,
    variables,
  )

export const updateUser = async (
  variables: object,
  graphql: string,
): Promise<
  FetchResult<{
    updateUser: {
      user: User
    }
  }>
> =>
  mutation(
    gql`
      mutation updateUser(
        $uuid: ID!
        $name: String
        $email: String
        $locale: String
        $otpEnable: Boolean
        $otpCode: String
      ) {
        updateUser(
          input: {
            uuid: $uuid
            name: $name
            email: $email
            locale: $locale
            otpAction: { enable: $otpEnable, code: $otpCode }
          }
        ) {
          ${graphql}
        }
      }
    `,
    variables,
  )

export const forgotPassword = async (
  variables: object,
): Promise<
  FetchResult<{
    forgotPassword: {
      success: boolean
    }
  }>
> =>
  mutation(
    gql`
      mutation forgotPassword($email: String!) {
        forgotPassword(input: { email: $email }) {
          success
        }
      }
    `,
    variables,
  )

export const resetPassword = async (
  variables: object,
): Promise<
  FetchResult<{
    resetPassword: {
      success: boolean
    }
  }>
> =>
  mutation(
    gql`
      mutation resetPassword(
        $token: String!
        $email: String!
        $password: String!
        $passwordConfirmation: String!
      ) {
        resetPassword(
          input: {
            token: $token
            email: $email
            password: $password
            passwordConfirmation: $passwordConfirmation
          }
        ) {
          success
        }
      }
    `,
    variables,
  )
