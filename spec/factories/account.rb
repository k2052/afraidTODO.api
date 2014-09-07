FactoryGirl.define do
  factory :account do
    email { "#{Faker::Internet.user_name}_#{rand(0...1000)}@example.org" }
    username { Faker::Internet.user_name.gsub('.','') + "_#{rand(0...20000)}" }
    password 'testpass'
    password_confirmation 'testpass'
    name { Faker::Name.name }
    role 'test'
  end
end
