# frozen_string_literal: true

users = []

3.times do |i|
  users << User.create!(
    email: "user#{i}@example.com",
    name: "User #{i}",
    password: "User#{i}pass!",
    locale: 'en',
  )
end

50.times do |i|
  user = users.sample
  user.posts.create!(
    title: "Post #{i}",
    body: "Post #{i}",
  )
end
