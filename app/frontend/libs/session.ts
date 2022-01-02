import { session, get } from '~/libs/stores'

export const getSession = function () {
  return get(session)
}

export const setSession = function (value: object) {
  session.set(value)

  let json = JSON.stringify(value)
  localStorage.setItem('session', json)

  return true
}

export const clearSession = function () {
  let json = JSON.stringify({})
  localStorage.setItem('session', json)

  session.set({})

  return true
}

export { session }
