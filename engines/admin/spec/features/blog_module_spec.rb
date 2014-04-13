describe "Admin Blog Module" do

  before(:each) do
    user = create(:user)
    sign_in_with user.email, user.password
    click_link "Blog"
  end

  describe "create function" do

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

  describe "index page" do
    before(:each) do
      create_list(:blog, 5)
      click_link "Blog"
    end

    it "shows all the blogs" do
      within(:css, "table.table") do
        expect(page).to have_content("Blog 5")
      end
    end

    it "has a link to show every blog record" do
      within(:css, "table.table") do
        expect(page.first(:link, "Show")[:href]).to eq admin_app.blog_path(1)
      end
    end

    it "has a link to delete every blog record" do
      within(:css, "table.table") do
        expect(page.first(:link, "Delete")[:href]).to eq admin_app.blog_path(1)
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
