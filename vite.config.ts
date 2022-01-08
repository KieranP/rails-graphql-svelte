import { defineConfig } from 'vite'
import RubyPlugin from 'vite-plugin-ruby'
import { svelte } from '@sveltejs/vite-plugin-svelte'

// https://vitejs.dev/config/
export default defineConfig({
  clearScreen: false,
  plugins: [
    RubyPlugin(),
    svelte({})
  ],
})
