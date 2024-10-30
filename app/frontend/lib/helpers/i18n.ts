import {
  _,
  addMessages,
  getLocaleFromNavigator,
  init,
  locale,
  locales,
} from 'svelte-i18n'

import en from '$lib/i18n/en.json'
addMessages('en', en)

import de from '$lib/i18n/de.json'
addMessages('de', de)

import { getSession } from '$lib/helpers/session'

let initialLocale = getSession().user?.locale ?? null
initialLocale ??= getLocaleFromNavigator()
initialLocale ??= 'en'

await init({
  initialLocale,
  fallbackLocale: 'en',
})

export { _, locales as allLocales, locale as setLocale }
