require 'spec_helper'

describe "Admin Access" do
  context "when not logged in" do
    it "redirects to admin login page" do
      visit ADMIN_ENGINE_PATH
      expect(page.current_path).to eq "/#{ADMIN_ENGINE_PATH}/login"
    end
  end

  describe "Sign in" do
    context "when user is invalid" do
      it "does not allow access" do
        invalid_user = build(:user)
        sign_in_with(invalid_user.email, invalid_user.password)
        expect(page).to have_content "Invalid email or password."
      end
    end

    context "when user is valid" do
      it "allows access" do
        valid_user = create(:user)
        sign_in_with(valid_user.email, valid_user.password)
        expect(page).to have_content "Signed in successfully."
      end
    end
  end

  describe "Sign out" do
    context "when user is signed in" do
      it "signs out the current user" do
        valid_user = create(:user)
        sign_in_with(valid_user.email, valid_user.password)
        click_link "Logout"

        expect(page.current_path).to eq "/#{ADMIN_ENGINE_PATH}/login"
      end
    end
  end

  describe "Admin Page" do
    before(:each) do
      user = create(:user)
      sign_in_with user.email, user.password
    end

    context "when signed in" do
      it "has a link to blog" do
        within(:css, "nav.left-nav") do
          expect(page).to have_link "Blog"
        end
      end
    end
  end


  #FIXME: Put this on a support file
  private
  def sign_in_with(email, password)
    visit "/#{ADMIN_ENGINE_PATH}/login"
    fill_in :user_email, with: email
    fill_in :user_password, with: password
    click_button "Sign in"
  end
end
