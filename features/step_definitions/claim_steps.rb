include UtilFunctions
include GlobalContants

Then(/I filter new claims to "([^"]*)"$/) do |opt|
  @claim.selectOption("New")
  results = @claim.getResults
  if results.length > 0
    @claim.editClaim(results[0].elements(:css => "div")[3])
    case opt
      when "accept"
        @claim.acceptClaim
      when "decline"
        @claim.denyClaim
    end
  end
end

Then(/I filter by "([^"]*)" to verify returned results$/) do |opt|
  @claim.selectOption(opt)
  results = @claim.getResults
  puts "results.length: #{results.length}"
  results.each do |item|
   puts "\n"
   puts item.elements(:css => "div")[0].text + "-"
   puts item.elements(:css => "div")[1].text + "-"
   puts item.elements(:css => "div")[2].text
  end
end

Then(/I filter by "([^"]*)" to count returned results$/) do |opt|
  @claim.selectOption(opt)
  puts "Found: #{@claim.countResults}"
end
