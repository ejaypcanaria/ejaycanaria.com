# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :blog do

    sequence(:title) {|i| "Blog #{i}"}
    sequence(:permalink) {|i| "blog-#{i}"}
    contents "TL;DR;"
    status "drafted"

  end
end
