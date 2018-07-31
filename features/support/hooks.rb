require 'selenium-cucumber'
require_all 'lib'

#Cucumber provides a number of hooks which allow us to run blocks at various points in the Cucumber test cycle
Before do
  #All page-objects initialization here
  @login = Login.new($browser)
  @header = Header.new($browser)
  @home = Home.new($browser)

end

Before ('not @auto_login_logout') do
  @login.loadAUT(URL)
end

Before ('@auto_login_logout') do
  @login.loadAUT(URL)
  @login.login(USER, PWD)
end

#You could also enable to browser to full screen
#driver.find_element(:tag_name => 'html').send_keys(Selenium::WebDriver::Keys[:f11])
After do |scenario|
  if scenario.failed?
    if ENV['BROWSER'].eql? 'headless'
      puts "I am here to take screenshots"
      headless.take_screenshot("reports/headless_"+scenario.name+".jpeg")
      embed("reports/headless_"+scenario.name+".jpeg", 'image/jpeg')
    else
      $browser.screenshot.save("reports/normal_"+scenario.name+".png")
      embed("reports/normal_"+scenario.name+".png", 'image/png')
    end
  end
  $browser.close
end

After '@auto_login_logout' do
@header.logOut
$browser.close
end

After 'not @auto_login_logout' do
  $browser.close
end
