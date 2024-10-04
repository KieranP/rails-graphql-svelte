import { get, writable } from 'svelte/store'

const session_str = window.localStorage.getItem('session')
const session_init = session_str === null ? {} : JSON.parse(session_str)
export const session = writable<{
  token?: string
  user?: { uuid: string; name: string; locale: string }
}>(session_init)

export const getSession = function () {
  return get(session)
}

export const setSession = function (value: object) {
  session.set(value)

  const json = JSON.stringify(value)
  window.localStorage.setItem('session', json)

  return true
}

export const clearSession = function () {
  const json = JSON.stringify({})
  window.localStorage.setItem('session', json)

  session.set({})

  return true
}
