import type { User } from '$lib/types/User'

export interface Post {
  uuid: string
  title: string
  body: string
  user: User
}

export interface PostSubmission {
  title: string | undefined
  body: string | undefined
}
