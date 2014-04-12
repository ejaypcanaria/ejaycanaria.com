describe "Admin Blog Panel" do

  before(:each) do
    user = create(:user)
    sign_in_with user.email, user.password
  end

  describe "create function" do
    before(:each) do
      click_link "Blog"
    end

    it "has a create link" do
      within(:css, "#blog-header") do
        expect(page).to have_link("Create")
      end
    end

    describe "create link" do
      it "redirects to new blog page" do
        within(:css, "#blog-header") do
          click_link "Create"
          expect(page.current_path).to eq admin_app.new_blog_path
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
