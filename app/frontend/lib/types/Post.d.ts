import type { User } from '$lib/types/User'

export type Post = {
  uuid: string
  title: string
  body: string
  user: User
}

export type PostSubmission = {
  title: string
  body: string
}
