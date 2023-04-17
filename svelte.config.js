import adapter from '@sveltejs/adapter-static'
import { vitePreprocess } from '@sveltejs/kit/vite'

/** @type {import('@sveltejs/kit').Config} */
const config = {
  preprocess: vitePreprocess(),

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
        'connect-src': ['self'],
        'style-src': ['self'],
        'img-src': ['self']
      }
    }
  }
}

export default config
