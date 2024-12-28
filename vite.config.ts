import { defineConfig, type UserConfig } from 'vite'

import { sveltekit } from '@sveltejs/kit/vite'

const config: UserConfig = defineConfig({
  clearScreen: false,
  plugins: [sveltekit()],
  build: {
    target: 'esnext',
  },
  css: {
    devSourcemap: true,
    preprocessorOptions: {
      scss: {
        api: 'modern-compiler',
      },
    },
  },
})

export default config
