FactoryGirl.define do
  factory :task do
    title { Faker::Lorem.words(5).join(" ") }
  end
end
