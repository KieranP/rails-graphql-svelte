users = 3.times.map { |i|
  User.create!(
    email: "user#{i}@example.com",
    name: "User #{i}",
    password: "user#{i}pass",
    locale: 'en'
  )
}

50.times do |i|
  user = users.sample
  user.posts.create!(
    title: "Post #{i}",
    body: "Post #{i}"
  )
end
