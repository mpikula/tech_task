FactoryBot.define do
  factory :user do
    username {"test123"}
    password_hash {"test123"}
    login_attempts {0}
    account_locked {false}
  end
end
