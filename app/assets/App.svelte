<script>
  import { Router, Route } from 'svelte-navigator'

  import Layout from '@layouts/main'
  import HomeIndex from '@pages/home/index'
  import AboutIndex from '@pages/about/index'

  import UsersShow from '@pages/users/show'
  import UsersEdit from '@pages/users/edit'

  import PostsIndex from '@pages/posts/index'
  import PostsShow from '@pages/posts/show'
  import PostsNew from '@pages/posts/new'
  import PostsEdit from '@pages/posts/edit'

  import Login from '@pages/auth/login'
  import Logout from '@pages/auth/logout'
  import NotFound from '@pages/errors/404'
</script>

<Router>
  <Layout>
    <Route path="/users/*">
      <Route path="/:id" component="{UsersShow}" />
      <Route path="/:id/edit" component="{UsersEdit}" />
    </Route>

    <Route path="/posts/*">
      <Route path="/" component="{PostsIndex}" />
      <Route path="/new" component="{PostsNew}" />
      <Route path="/:id" component="{PostsShow}" />
      <Route path="/:id/edit" component="{PostsEdit}" />
    </Route>

    <Route path="/about" component="{AboutIndex}" />

    <Route path="/login" component="{Login}" />
    <Route path="/logout" component="{Logout}" />

    <Route path="/" component="{HomeIndex}" />
    <Route path="*" component="{NotFound}" />
  </Layout>
</Router>
