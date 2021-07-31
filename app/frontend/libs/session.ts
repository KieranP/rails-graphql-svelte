import { session, get } from '@libs/stores'

let getSession = function () {
  return get(session)
}

let setSession = function (value: object) {
  session.set(value)

  let json = JSON.stringify(value)
  localStorage.setItem('session', json)

  return true
}

let clearSession = function () {
  let json = JSON.stringify({})
  localStorage.setItem('session', json)

  session.set({})

  return true
}

export { session, getSession, setSession, clearSession }
