import { defineConfig } from 'vite'
import { sveltekit } from '@sveltejs/kit/vite'

export default defineConfig({
  clearScreen: false,
  plugins: [sveltekit()],
  css: {
    devSourcemap: true
  }
})
