import {
  ApolloClient,
  ApolloLink,
  InMemoryCache,
  createHttpLink,
  gql
} from '@apollo/client/core'

import ActionCable from '@rails/actioncable'
import { ActionCableLink } from 'graphql-ruby-client'

const cable = ActionCable.createConsumer(
  import.meta.env.SNOWPACK_PUBLIC_CABLE_ENDPOINT
)

const hasSubscriptionOperation = ({ query: { definitions } }) => {
  return definitions.some(
    ({ kind, operation }) => kind === 'OperationDefinition' && operation === 'subscription'
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
}

const client = new ApolloClient({ link, cache, defaultOptions })

export const query = (graphql, variables) => (
  client.query({
    query: gql`${graphql}`,
    variables
  })
)

export const mutation = (graphql, variables) => (
  client.mutate({
    mutation: gql`${graphql}`,
    variables
  })
)

export const subscribe = (graphql, variables) => (
  client.subscribe({
    query: gql`${graphql}`,
    variables
  })
)
