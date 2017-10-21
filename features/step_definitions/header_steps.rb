include UtilFunctions
include GlobalContants


Then(/I load Home Page$/) do
  @header.loadHome
  fail "Home Page fails to be loaded" unless @home.home_page_welcome_text.text.eql? HOME_PAGE_WELCOME_TEXT
end

Then(/I load Claims Page$/) do
  @header.loadClaims
  @claim.selectOption("All")
  fail "Claims Page fails to be loaded" unless @claim.text_claim_page.text.eql? CLAIM_PAGE_TEXT
end

Then(/I load Users Page$/) do
  @header.loadUsers
  fail "Users Page fails to be loaded" unless @user.user_page_text.text.eql? USERS_PAGE_TEXT
end

Then(/I load Settings Page$/) do
  @header.loadSettings
  fail "Settings Page fails to be loaded" unless @setting.settings_page_welcome_text.text.eql? SETTINGS_PAGE_TEXT
end
