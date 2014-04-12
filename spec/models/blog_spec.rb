require 'spec_helper'

describe Blog do

  it "is not valid without title" do
    Blog.skip_callback(:validation, :before, :generate_permalink)

    invalid_blog = build(:blog, title: nil)
    expect(invalid_blog).to have_at_least(1).errors_on(:title)

    Blog.set_callback(:validation, :before, :generate_permalink)
  end

  it "validates the maximum lenght of permalink is 500" do
    too_long_title = (1..501).map{ "a" }.join("")
    long_titled_blog = build(:blog, title: too_long_title)
    expect(long_titled_blog).to have_at_least(1).errors_on(:permalink)
  end

  it "generates a permalink based on title" do
    blog = create(:blog, title: "This is a sample blog")
    expect(blog.permalink).to eq blog.title.parameterize
  end

end
