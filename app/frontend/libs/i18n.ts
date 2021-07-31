import {
  addMessages,
  init,
  getLocaleFromNavigator,
  locales,
  locale,
  _
} from 'svelte-i18n'
import { getSession } from '@libs/session'

import en from '@i18n/en.json'
addMessages('en', en)

import de from '@i18n/de.json'
addMessages('de', de)

let initialLocale = getSession()?.user?.locale
initialLocale ??= getLocaleFromNavigator()
initialLocale ??= 'en'

init({
  initialLocale: initialLocale,
  fallbackLocale: 'en'
})

export { locales as allLocales, locale as setLocale, _ }
