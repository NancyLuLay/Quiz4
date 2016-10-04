FactoryGirl.define do
  factory :auction do
    sequence(:title)  {    Faker::Space  }
    description       {    Faker::ChuckNorris.fact     }
    reserve_price     {    10 + rand(100000)           }
    end_date          {    Time.now + 30.days          }
  end
end
