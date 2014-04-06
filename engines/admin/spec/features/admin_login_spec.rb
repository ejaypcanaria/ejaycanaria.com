require 'spec_helper'

describe "Admin Login" do
  context "when not logged in" do
    it "should redirect to admin login page" do
      visit ADMIN_ENGINE_PATH
      expect(page.current_path).to eql "/#{ADMIN_ENGINE_PATH}/login"
    end
  end
end
