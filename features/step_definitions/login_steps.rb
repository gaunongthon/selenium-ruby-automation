include UtilFunctions
include GlobalContants

Then(/I am at Automation Practice Login Page$/) do
  wait_for_transition(@login.login_page_welcome_text)
  #puts "Found : #{@login.login_page_welcome_text.text}"
  #puts "Expected : #{LOGIN_WELCOME_TEXT}"
  fail "Login Page fails to be loaded" unless getText(@login.login_page_welcome_text).eql? LOGIN_WELCOME_TEXT
end

Then(/I log in Automation Practice$/) do
  @login.login(USER, PWD)
end

Then(/I am at Automation Practice Home Page$/) do
  wait_for_transition(@home.home_page_welcome_text)
  #puts "Found : #{@home.home_page_welcome_text.text}"
  #puts "Expected : #{HOME_PAGE_WELCOME_TEXT}"
  fail "Home Page fails to be loaded" unless getText(@home.home_page_welcome_text).eql? HOME_PAGE_WELCOME_TEXT
end

Then(/I log out Automation Practice$/) do
  @header.logOut
end
