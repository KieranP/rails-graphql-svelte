import { type Writable, writable } from 'svelte/store'

import type { GraphQLFormattedError } from 'graphql'

export const errors: Writable<
  readonly GraphQLFormattedError[] | Array<Record<string, string>>
> = writable([])
