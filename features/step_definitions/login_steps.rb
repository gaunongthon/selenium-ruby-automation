include UtilFunctions
include GlobalContants

Then(/I am at Su Portal Login Page$/) do
  wait_for_transition(@login.login_page_welcome_text)
  puts "Found : #{@login.login_page_welcome_text.text}"
  puts "Expected : #{LOGIN_WELCOME_TEXT}"
  fail "Login Page fails to be loaded" unless @login.login_page_welcome_text.text.eql? LOGIN_WELCOME_TEXT
end

Then(/I log in Su Portal as an admin$/) do
  @login.login(@env_info, @env)
end

Then(/I am at Su Portal Home Page$/) do
  wait_for_transition(@home.home_page_welcome_text)
  puts "Found : #{@home.home_page_welcome_text.text}"
  puts "Expected : #{HOME_PAGE_WELCOME_TEXT}"
  fail "Home Page fails to be loaded" unless @home.home_page_welcome_text.text.eql? HOME_PAGE_WELCOME_TEXT
end

Then(/I log out Su Portal$/) do
  @header.logOut
end