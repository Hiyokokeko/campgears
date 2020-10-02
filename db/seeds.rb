#カテゴリー
Category.create([
  { name: 'テント' },
  { name: 'タープ' },
  { name: 'シュラフ' },
  { name: 'テーブル・チェア' },
  { name: '調理器具・カトラリー' },
  { name: '焚火台' },
  { name: 'ランタン' },
  { name: 'ペグ・ハンマー・ポール・小物' },
  { name: 'クーラーボックス' },
  { name: '新人向け' },
  { name: 'その他' }
])

if Rails.env == 'development'
#ユーザー
User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
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
