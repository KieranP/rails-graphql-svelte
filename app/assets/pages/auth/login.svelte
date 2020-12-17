<script>
  import { loginUser } from '../../libs/queries'
  import { session, errors } from '../../libs/stores'
  import { navigate } from 'svelte-navigator'

  let email
  let password

  function submit() {
    loginUser({email, password}, `user { id email name }`).then(res => {
      if (res.errors) {
        errors.set(res.errors)
      } else {
        let data = res.data
        session.set(data.loginUser)
        localStorage.setItem('session',
          JSON.stringify(data.loginUser))
        navigate('/')
      }
    })
  }
</script>

<h1>Login</h1>

<form on:submit|preventDefault={submit}>
  <div class="mb-3">
    <label for="email" class="form-label">Email</label>
    <input type="email" class="form-control" id="email" bind:value={email} />
  </div>

  <div class="mb-3">
    <label for="password" class="form-label">Password</label>
    <input type="password" class="form-control" id="password" bind:value={password} />
  </div>

  <div class="mb-3">
    <button type="submit" class="btn btn-primary">
      Login
    </button>
  </div>
</form>
