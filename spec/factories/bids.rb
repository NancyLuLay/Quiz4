FactoryGirl.define do
  factory :bid do
    association :user, factory: :user
    association :auction, factory: :auction
    amount {1 + rand(100)}
  end
end
