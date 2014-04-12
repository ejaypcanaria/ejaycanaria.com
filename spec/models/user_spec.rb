describe User do

  it "is not valid without name" do
    user = build(:user, name: nil)
    expect(user).to have_at_least(1).errors_on(:name)
  end

end
