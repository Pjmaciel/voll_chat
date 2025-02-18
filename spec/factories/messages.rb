FactoryBot.define do
  factory :message do
    content { "Hello!" }
    association :sender, factory: :user
    association :recipient, factory: :user, email: 'recipient@example.com'
    read { false }
  end
end