include UtilFunctions
include GlobalContants

Then(/I verify returned results$/) do
  results = @user.getResults
  puts "results.length: #{results.length}"
  results.each do |item|
   puts "\n"
   puts item.elements(:css => "div")[0].text + " " + item.elements(:css => "div")[1].text
  end
end

Then(/I count returned results$/) do
  puts "Found: #{@user.countResults}"
end

Then(/I click next page$/) do
  @user.clickNext
end

Then(/I click previous page$/) do
  @user.clickPrevious
end

Then(/I switch to manage Users$/) do
  @user.switchUsers
end

Then(/I switch to manage Cars$/) do
  @user.switchCars
end
