FactoryGirl.define do
  factory :user, aliases: [:author, :requestor] do
    sequence(:email) { |i| "user#{i}@example.com" }
    slack 
  end
end