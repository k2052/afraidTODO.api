FactoryGirl.define do
  factory :token do
  end

  factory :token_expired, parent: :token do
    expires_at { DateTime.now() }
  end
end
