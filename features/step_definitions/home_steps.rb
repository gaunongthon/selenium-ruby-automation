include UtilFunctions
include GlobalContants

Then(/I load request taxi form$/) do
  @home.loadRequestTaxiForm
end

Then(/I search for passenger "([^"]*)" with phone number "([^"]*)"$/) do |psgname, phonenumber|
  @home.selectPassenger(psgname, phonenumber)
end

Then(/I input "([^"]*)" as pick-up coordinates$/) do |text|
  @home.setFromLocationByCoordinate(text)
end

Then(/I type "([^"]*)" as destination location$/) do |text|
  @home.setToLocationByLocation(text)
end

Then(/I hit Estimate button$/) do
  @home.hitEstimate
end
