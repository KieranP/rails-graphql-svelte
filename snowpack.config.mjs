/** @type {import("snowpack").SnowpackUserConfig } */
export default {
  mount: {
    'static': { url: '/', static: true },
    'app/assets': { url: '/_dist_' },
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
    '@components': './app/assets/components',
    '@i18n': './app/assets/i18n',
    '@libs': './app/assets/libs',
    '@pages': './app/assets/pages',
    '@queries': './app/assets/queries',
    '@tstypes': './app/assets/types'
  },
  // optimize: {
  //   target: 'es2017',
  //   bundle: true,
  //   minify: true
  // }
}
