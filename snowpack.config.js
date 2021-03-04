module.exports = {
  mount: {
    'static': '/',
    'app/assets': '/_dist_',
  },
  plugins: [
    '@snowpack/plugin-dotenv',
    '@snowpack/plugin-svelte',
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
    '@queries': './app/assets/queries'
  },
  // optimize: {
  //   target: 'es2017',
  //   bundle: true,
  //   minify: true
  // }
}
