import type { Post } from '$lib/types/post'

export interface User {
  uuid: string
  name: string
  email: string
  locale: string

  otpEnabled: string
  otpProvisioningUrl: string

  posts: Post[]
}
