import type { Post } from '@types/Post'

export type User = {
  uuid: string
  name: string
  email: string
  locale: string

  otpEnabled: string
  otpProvisioningUrl: string

  posts: Post[]
}
