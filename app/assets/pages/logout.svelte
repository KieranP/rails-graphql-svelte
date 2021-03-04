<script>
  import { logoutUser } from '@libs/queries'
  import { clearSession } from '@libs/session'
  import { errors } from '@libs/stores'
  import { setLocale } from '@libs/i18n'
  import { goto } from '@roxi/routify'

  logoutUser({}, `user { uuid }`).then(res => {
    clearSession()
    setLocale.set('en')

    $goto('/')
  }).catch(error => {
    errors.set(error.graphQLErrors)
  })
</script>
