FactoryBot.define do
  factory :user do
    email {"test@test"}
    password {"test123"}
    password_confirmation {password}
  end
end
