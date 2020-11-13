#カテゴリー
Category.create([
  { name: 'テント・タープ・ハンモック' },
  { name: '寝具' },
  { name: 'ザック' },
  { name: 'ファニチャー' },
  { name: '調理器具・カトラリー' },
  { name: '火器・焚火台' },
  { name: 'ライト・ランタン' },
  { name: 'ペグ・ハンマー・ポール・アクセサリー' },
  { name: 'ファッション' },
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
