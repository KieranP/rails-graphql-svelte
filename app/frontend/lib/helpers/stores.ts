import { writable } from 'svelte/store'

import type { GraphQLFormattedError } from 'graphql'

const errors_init:
  | Array<Record<string, string>>
  | readonly GraphQLFormattedError[] = []
export const errors = writable(errors_init)
