import {
  ApolloClient,
  ApolloLink,
  InMemoryCache,
  createHttpLink,
  gql
} from '@apollo/client/core'

import type { DefaultOptions } from '@apollo/client/core'

import { getMainDefinition } from '@apollo/client/utilities'

import ActionCable from '@rails/actioncable'
import { ActionCableLink } from 'graphql-ruby-client'

const cable = ActionCable.createConsumer(
  import.meta.env.SNOWPACK_PUBLIC_CABLE_ENDPOINT
)

const hasSubscriptionOperation = ({ query }:any) => {
  const definition = getMainDefinition(query)
  return (
    definition.kind === 'OperationDefinition' &&
    definition.operation === 'subscription'
  )
}

const link = ApolloLink.split(
  hasSubscriptionOperation,
  new ActionCableLink({cable}),
  createHttpLink({
    uri: import.meta.env.SNOWPACK_PUBLIC_API_ENDPOINT,
    credentials: 'include'
  })
)

const cache = new InMemoryCache({})

const defaultOptions = {
  watchQuery: { fetchPolicy: 'no-cache' },
  query: { fetchPolicy: 'no-cache' }
} as DefaultOptions

const client = new ApolloClient({ link, cache, defaultOptions })

export const query = (graphql:string, variables:object) => (
  client.query({
    query: gql`${graphql}`,
    variables
  })
)

export const mutation = (graphql:string, variables:object) => (
  client.mutate({
    mutation: gql`${graphql}`,
    variables
  })
)

export const subscribe = (graphql:string, variables:object) => (
  client.subscribe({
    query: gql`${graphql}`,
    variables
  })
)
