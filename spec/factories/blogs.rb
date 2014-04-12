FactoryGirl.define do
  factory :blog do
    user
    sequence(:title) {|i| "Blog #{i}"}
    sequence(:permalink) {|i| "blog-#{i}"}
    contents "TL;DR;"
    status "drafted"

  end
end
