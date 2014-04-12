# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:email) {|i| "sample#{i}@example.com"}
    password "password123"
    password_confirmation "password123"
  end
end
