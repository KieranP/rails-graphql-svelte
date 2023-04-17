import {
  addMessages,
  init,
  getLocaleFromNavigator,
  locales,
  locale,
  _
} from 'svelte-i18n'
// import { getSession } from '$lib/helpers/session'

import en from '$lib/i18n/en.json'
addMessages('en', en)

import de from '$lib/i18n/de.json'
addMessages('de', de)

let initialLocale = null // getSession()?.user?.locale
initialLocale ??= getLocaleFromNavigator()
initialLocale ??= 'en'

init({
  initialLocale: initialLocale,
  fallbackLocale: 'en'
})

export { locales as allLocales, locale as setLocale, _ }
