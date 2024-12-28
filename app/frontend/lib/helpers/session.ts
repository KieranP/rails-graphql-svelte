import { get, type Writable, writable } from 'svelte/store'

import type { User } from '$lib/types/user'

interface Session {
  user?: Pick<User, 'uuid' | 'name' | 'locale'>
}

const session_str = window.localStorage.getItem('session')
const session_init = session_str === null ? {} : JSON.parse(session_str)
export const session: Writable<Session> = writable(session_init)

export const getSession = (): Session => {
  return get(session)
}

export const setSession = (value: object) => {
  session.set(value)

  const json = JSON.stringify(value)
  window.localStorage.setItem('session', json)

  return true
}

export const clearSession = () => {
  const json = JSON.stringify({})
  window.localStorage.setItem('session', json)

  session.set({})

  return true
}
