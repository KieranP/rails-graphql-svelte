import { session, get } from '$lib/helpers/stores'

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

export { session }
