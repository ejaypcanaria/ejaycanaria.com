FactoryGirl.define do
  factory :blog do
    author factory: :user
    sequence(:title) {|i| "Blog #{i}"}
    sequence(:permalink) {|i| "blog-#{i}"}
    contents "TL;DR;"
    status "drafted"

  end
end
