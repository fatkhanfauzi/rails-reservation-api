FactoryBot.define do
  factory :guest do
    sequence(:uuid) { |n| "uuid_#{n}" }
    sequence(:first_name) { |n| "first_name_#{n}" }
    sequence(:last_name) { |n| "last_name_#{n}" }
    sequence(:phone) { |n| "+61123456#{n}" }
    sequence(:email) { |n| "email_#{n}@email.com" }
  end
end
