include UtilFunctions
include GlobalContants

Then(/I want to manage "([^"]*)"$/) do |text|
  @home.select_managed_option(text)
end
