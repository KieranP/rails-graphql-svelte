import type { Post } from '@types/Post'

export interface User {
  uuid:string
  name:string
  email:string
  locale:string
  posts:Post[]
}
