import adapter from '@sveltejs/adapter-static'
import { vitePreprocess } from '@sveltejs/vite-plugin-svelte'

/** @type {import('@sveltejs/kit').Config} */
const config = {
  preprocess: vitePreprocess(),
  compilerOptions: {
    runes: true
  },

  kit: {
    adapter: adapter({
      pages: 'public',
      fallback: 'index.html'
    }),
    files: {
      assets: 'app/frontend/static',
      lib: 'app/frontend/lib',
      params: 'app/frontend/params',
      routes: 'app/frontend/routes',
      serviceWorker: 'app/frontend/service-worker',
      appTemplate: 'app/frontend/app.html',
      errorTemplate: 'app/frontend/error.html'
    },
    csp: {
      mode: 'hash',
      directives: {
        'default-src': ['none'],
        'script-src': ['self'],
        'connect-src': [
          'self',
          'https://api.apps.localhost/',
          'wss://api.apps.localhost/'
        ],
        'style-src': ['self'],
        'img-src': ['self']
      }
    }
  }
}

export default config
