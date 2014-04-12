module SessionHelpers
  def sign_in_with(email, password)
    visit "/#{ADMIN_ENGINE_PATH}/login"
    fill_in :user_email, with: email
    fill_in :user_password, with: password
    click_button "Sign in"
  end
end
