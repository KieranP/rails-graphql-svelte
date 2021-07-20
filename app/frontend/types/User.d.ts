import type { Post } from '@types/Post'

export type User = {
  uuid:string
  name:string
  email:string
  locale:string
  posts:Post[]
}