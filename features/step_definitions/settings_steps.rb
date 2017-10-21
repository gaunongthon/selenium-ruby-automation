include UtilFunctions
include GlobalContants

Then(/I edit "([^"]*)" with new "([^"]*)"$/) do |setting, value|
  results = @setting.getResults
  if results.length > 0
    results.each do |item|
      t = item.element(:css => "div > h5")
      if t.text.eql? setting
        scrollElementToCenter(t)
        v = item.element(:css => "div > span")
        clickElement(v)
        input = item.element(:css => "div > input")
        sendKeys(input, value)
        sendKeys(input, :return)
      end
    end
  end
end

Then(/I verify "([^"]*)" key$/) do |setting|
  results = @setting.getResults
  if results.length > 0
    results.each do |item|
      t = item.element(:css => "div > h5")
      if t.text.eql? setting
        v = item.element(:css => "div > span")
        puts "\nFound: #{t.text}"
        puts " - #{v.text}"
      end
    end
  end
end

Then(/I count existing settings$/) do
  puts "\nFound: #{@setting.countResults}"
end
