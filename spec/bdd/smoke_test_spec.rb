require 'spec_helper'

describe "Smoke test" do

  it "can view the home page" do
    visit '/'
    expect(page.title).to eql('Ejay Canaria - Welcome to My Website!')
  end

  it "can view the blog" do
    visit '/blog'
    expect(page.title).to eql('Ejay Canaria - Blog')
  end

  it "can view the photographs" do
    visit '/photographs'
    expect(page.title).to eql('Ejay Canaria - Photographs')
  end

  it "can view the manifesto" do
    visit '/manifesto'
    expect(page.title).to eql('Ejay Canaria - Manifesto')
  end

  it "can view the about page" do
    visit '/about'
    expect(page.title).to eql('Ejay Canaria - About')
  end

end
