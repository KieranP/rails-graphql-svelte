import { writable, get } from 'svelte/store'

let session_str = localStorage.getItem('session')
let session_init = session_str ? JSON.parse(session_str) : {}
export const session = writable(session_init)

let errors_init: { [key: string]: string }[] = []
export const errors = writable(errors_init)

export { get }
