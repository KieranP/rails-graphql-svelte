import {
  ApolloClient,
  ApolloLink,
  InMemoryCache,
  createHttpLink,
  gql
} from '@apollo/client/core'

import type { DefaultOptions, DocumentNode } from '@apollo/client/core'

import { getMainDefinition } from '@apollo/client/utilities'

import { createConsumer } from '@rails/actioncable'
import ActionCableLink from 'graphql-ruby-client/subscriptions/ActionCableLink'

const cable = createConsumer(import.meta.env.VITE_CABLE_ENDPOINT as string)

const hasSubscriptionOperation = ({ query }: any) => {
  const definition = getMainDefinition(query)
  return (
    definition.kind === 'OperationDefinition' &&
    definition.operation === 'subscription'
  )
}

const link = ApolloLink.split(
  hasSubscriptionOperation,
  new ActionCableLink({ cable }),
  createHttpLink({
    uri: import.meta.env.VITE_GRAPHQL_ENDPOINT as string,
    credentials: 'include'
  })
)

const cache = new InMemoryCache({})

const defaultOptions: DefaultOptions = {
  watchQuery: { fetchPolicy: 'no-cache' },
  query: { fetchPolicy: 'no-cache' },
  mutate: { fetchPolicy: 'no-cache' }
}

const client = new ApolloClient({ link, cache, defaultOptions })

export const query = (graphql: DocumentNode, variables: object) =>
  client.query({
    query: graphql,
    variables
  })

export const mutation = (graphql: DocumentNode, variables: object) =>
  client.mutate({
    mutation: graphql,
    variables
  })

export const subscribe = (graphql: DocumentNode, variables: object) =>
  client.subscribe({
    query: graphql,
    variables
  })

export { gql }
