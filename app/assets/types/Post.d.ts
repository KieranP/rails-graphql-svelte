import type { User } from '@types/User'

export interface Post {
  uuid:string
  title:string
  body:string
  user:User
}

export interface PostSubmission {
  title:string
  body:string
}
