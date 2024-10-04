import { defineConfig } from 'vite'

import { sveltekit } from '@sveltejs/kit/vite'

export default defineConfig({
  clearScreen: false,
  plugins: [sveltekit()],
  build: {
    target: 'esnext'
  },
  css: {
    devSourcemap: true,
    preprocessorOptions: {
      scss: {
        api: 'modern-compiler'
      }
    }
  }
})
