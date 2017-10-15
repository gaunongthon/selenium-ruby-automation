include UtilFunctions
include GlobalContants
require_all 'lib'

Then(/I log in Su Portal as an admin$/) do
  Authenticate.new.login(@env_info, @suPortalLogin, @browser)
end

Then(/I am at Su Portal Home Page$/) do
  wait_for_transition(@suPortalHome.home_page_welcome_text)
  puts "Found : #{@suPortalHome.home_page_welcome_text.text}"
  puts "Expected : #{HOME_PAGE_WELCOME_TEXT}"
  fail "Home Page fails to be loaded" unless @suPortalHome.home_page_welcome_text.text.eql? HOME_PAGE_WELCOME_TEXT
end

Then(/I log out Su Portal$/) do
  Authenticate.new.logout(@suPortalHome)
end

Then(/I am at Su Portal Login Page$/) do
  wait_for_transition(@suPortalLogin.login_page_welcome_text)
  puts "Found : #{@suPortalLogin.login_page_welcome_text.text}"
  puts "Expected : #{LOGIN_WELCOME_TEXT}"
  fail "Login Page fails to be loaded" unless @suPortalLogin.login_page_welcome_text.text.eql? LOGIN_WELCOME_TEXT
end
