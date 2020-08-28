#カテゴリー
# Category.create([
#   { name: '' },
#   { name: '' },
#   { name: '' },
#   { name: '' },
#   { name: '' },
#   { name: '' },
#   { name: '' },
#   { name: '' },
#   { name: '' },
#   { name: '' },
#   { name: 'その他' }
# ])

if Rails.env == 'development'
#ユーザー
User.create!(name:  "Admin",
             email: "admin_user@example.com",
             password:              "password",
             password_confirmation: "password",
             admin: true,)

User.create!(name:  "ゲストユーザー",
email: "test@example.com",
password:              "testuser",
password_confirmation: "testuser",)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,)
end

#マイクロポスト
users = User.order(:created_at).take(6)
50.times do
  title = Faker::Book.title
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.pages.create!(title: title,content: content) }
end
end
