import { gql, query, mutation, subscribe } from '$lib/helpers/graphql'

export const findUser = (variables: object, graphql: string) =>
  query(
    gql`
    query findUser($uuid: ID!) {
      findUser(uuid: $uuid) {
        ${graphql}
      }
    }
    `,
    variables
  )

export const watchUser = (variables: object, graphql: string) =>
  subscribe(
    gql`
    subscription watchUser($uuid: ID!) {
      userUpdated(uuid: $uuid) {
        ${graphql}
      }
    }
    `,
    variables
  )

export const createUser = (variables: object, graphql: string) =>
  mutation(
    gql`
    mutation createUser($email: String!, $name: String!, $locale: String!, $password: String!, $passwordConfirmation: String!) {
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
    `,
    variables
  )

export const updateUser = (variables: object, graphql: string) =>
  mutation(
    gql`
    mutation updateUser($uuid: ID!, $name: String, $email: String, $locale: String, $otpEnable: Boolean, $otpCode: String) {
      updateUser(input: {
        uuid: $uuid,
        name: $name,
        email: $email,
        locale: $locale,
        otpAction: {
          enable: $otpEnable,
          code: $otpCode
        }
      }) {
        ${graphql}
      }
    }
    `,
    variables
  )

export const forgotPassword = (variables: object, graphql: string) =>
  mutation(
    gql`
    mutation forgotPassword($email: String!) {
      forgotPassword(input: {
        email: $email
      }) {
        ${graphql}
      }
    }
    `,
    variables
  )

export const resetPassword = (variables: object, graphql: string) =>
  mutation(
    gql`
    mutation resetPassword($token: String!, $email: String!, $password: String!, $passwordConfirmation: String!) {
      resetPassword(input: {
        token: $token,
        email: $email,
        password: $password,
        passwordConfirmation: $passwordConfirmation
      }) {
        ${graphql}
      }
    }
    `,
    variables
  )
