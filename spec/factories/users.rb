FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "tester#{n}" }
    sequence(:email) { |n| "tester#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
    admin { false }
  end

  factory :admin_user, class: User do
    name { 'Admin' }
    email { 'admin@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
    admin { true }
  end

  factory :guest_user, class: User do
    name { 'ゲストユーザー' }
    email { 'test@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
