FactoryBot.define do
  factory :page do
    title { 'My gear' }
    content { 'My gear content' }
    association :user
  end
end
