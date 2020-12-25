import {
  addMessages,
  init,
  getLocaleFromNavigator,
  _
} from 'svelte-i18n'

import en from '@i18n/en.json'
addMessages('en', en)

init({
  initialLocale: getLocaleFromNavigator(),
  fallbackLocale: 'en',
})

export { _ }
