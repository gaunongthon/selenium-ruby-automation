include UtilFunctions
include GlobalContants


Then(/I click Contact Us$/) do
  @header.clickContactUs
  fail "Contact Us Page fails to be loaded" unless @home.home_page_welcome_text.text.eql? HOME_PAGE_CONTACT_TEXT
end

Then(/I click My Account$/) do
  @header.clickMyAccount
  fail "Contact Us Page fails to be loaded" unless @home.home_page_welcome_text.text.eql? HOME_PAGE_WELCOME_TEXT
end
