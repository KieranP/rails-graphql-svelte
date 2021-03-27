import { defineConfig } from 'vite'
import svelte from '@sveltejs/vite-plugin-svelte'

export default defineConfig(({ command, mode }) => {
  const isProduction = mode === 'production'
  return {
    root: './app/assets/',
    build: {
      outDir: '../../public',
      emptyOutDir: true,
      minify: isProduction
    },
    define: {
      'process.platform': null,
      'process.version': null,
    },
    plugins: [
      svelte({})
    ],
    resolve: {
      alias: {
        '@components': '/components',
        '@i18n': '/i18n',
        '@libs': '/libs',
        '@pages': '/pages',
        '@queries': '/queries'
      },
    }
  }
})
