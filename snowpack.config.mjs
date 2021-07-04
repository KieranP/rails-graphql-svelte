/** @type {import("snowpack").SnowpackUserConfig } */
export default {
  mount: {
    'app/frontend/static': { url: '/', static: true },
    'app/frontend': { url: '/_dist_' },
  },
  plugins: [
    '@snowpack/plugin-svelte',
    '@snowpack/plugin-dotenv',
    '@snowpack/plugin-typescript',
    '@snowpack/plugin-postcss',
  ],
  buildOptions: {
    out: './public',
    clean: true,
  },
  alias: {
    '@components': './app/frontend/components',
    '@i18n': './app/frontend/i18n',
    '@libs': './app/frontend/libs',
    '@pages': './app/frontend/pages',
    '@queries': './app/frontend/queries',
    '@tstypes': './app/frontend/types'
  },
  // optimize: {
  //   target: 'es2017',
  //   bundle: true,
  //   minify: true
  // }
}
