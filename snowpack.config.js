module.exports = {
  mount: {
    'static': '/',
    'app/assets': '/_dist_',
  },
  plugins: [
    '@snowpack/plugin-dotenv',
    '@snowpack/plugin-svelte',
    '@snowpack/plugin-webpack'
  ],
  buildOptions: {
    out: './public',
    clean: true,
  },
  install: [
    /* ... */
  ],
  installOptions: {
    /* ... */
  },
  devOptions: {
    /* ... */
  },
  proxy: {
    /* ... */
  },
  alias: {
    /* ... */
  },
}
