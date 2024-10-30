import { Kind, OperationTypeNode } from 'graphql'
import ActionCableLink from 'graphql-ruby-client/subscriptions/ActionCableLink'

import {
  ApolloClient,
  ApolloLink,
  createHttpLink,
  type DefaultOptions,
  type DocumentNode,
  gql,
  InMemoryCache,
  type Operation,
} from '@apollo/client/core'
import { getMainDefinition } from '@apollo/client/utilities'
import { createConsumer } from '@rails/actioncable'

const cable = createConsumer(import.meta.env.VITE_CABLE_ENDPOINT as string)

const hasSubscriptionOperation = ({ query }: Operation) => {
  const definition = getMainDefinition(query)
  return (
    definition.kind === Kind.OPERATION_DEFINITION &&
    definition.operation === OperationTypeNode.SUBSCRIPTION
  )
}

const link = ApolloLink.split(
  hasSubscriptionOperation,
  new ActionCableLink({ cable }),
  createHttpLink({
    uri: import.meta.env.VITE_GRAPHQL_ENDPOINT as string,
    credentials: 'include',
  }),
)

const cache = new InMemoryCache({})

const defaultOptions: DefaultOptions = {
  watchQuery: { fetchPolicy: 'no-cache' },
  query: { fetchPolicy: 'no-cache' },
  mutate: { fetchPolicy: 'no-cache' },
}

const client = new ApolloClient({ link, cache, defaultOptions })

export const query = async (graphql: DocumentNode, variables: object) =>
  client.query({
    query: graphql,
    variables,
  })

export const mutation = async (graphql: DocumentNode, variables: object) =>
  client.mutate({
    mutation: graphql,
    variables,
  })

export const subscribe = (graphql: DocumentNode, variables: object) =>
  client.subscribe({
    query: graphql,
    variables,
  })

export { gql }
