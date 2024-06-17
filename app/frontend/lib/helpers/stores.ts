import { writable, get } from 'svelte/store'

const session_str = localStorage.getItem('session')
const session_init = session_str ? JSON.parse(session_str) : {}
export const session = writable(session_init)

const errors_init: Record<string, string>[] = []
export const errors = writable(errors_init)

export { get }
