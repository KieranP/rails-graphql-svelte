import { writable } from 'svelte/store'

let session_str = localStorage.getItem('session')
let session_init = session_str ? JSON.parse(session_str) : {}
export let session = writable(session_init)

export let errors = writable([])
