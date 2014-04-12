# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:email) {|i| "sample#{i}@example.com"}
    sequence(:name) {|i| "User #{i}"}
    password "password123"
    password_confirmation "password123"
  end
end
