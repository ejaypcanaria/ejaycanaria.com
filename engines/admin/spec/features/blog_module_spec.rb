feature "Admin Blog Module" do

  before(:each) do
    user = create(:user)
    sign_in_with user.email, user.password
    create(:blog, title: "This is a sample blog")

    click_on "Blog"
  end

  describe "create functionality" do

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

    describe "create blog page" do
      it "creates a new blog record" do
        within(:css, "#blog-header") do
          click_link "Create"
        end

        fill_in :blog_title, with: "This is a sample blog"
        fill_in :blog_contents, with: "This is a sample content"
        click_button "Save Draft"

        expect(page).to have_content "Blog successfully created."
      end
    end
  end

  # describe "update functionality", js: true do
  #   it "has a save button" do

  #   end
  # end

  describe "index page" do
    it "shows all the blogs" do
      within(:css, "table.table") do
        expect(page).to have_content("This is a sample blog".titleize)
      end
    end

    it "has a link to show every blog record" do
      within(:css, "table.table") do
        expect(page.first(:link, "Show")[:href]).to eq admin_app.blog_path(Blog.last.id)
      end
    end

    it "has a link to delete every blog record" do
      within(:css, "table.table") do
        expect(page.first(:link, "Delete")[:href]).to eq admin_app.blog_path(Blog.last.id)
      end
    end
  end

  describe "delete functionality", :js => true do
    it "deletes a blog" do
      within(:css, "table.table") do
        page.click_link("Delete")
        expect(page).to_not have_link("Delete")
      end
    end
  end

end
