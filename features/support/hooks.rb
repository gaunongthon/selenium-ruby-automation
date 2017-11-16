require 'selenium-cucumber'
require_all 'lib'

#Cucumber provides a number of hooks which allow us to run blocks at various points in the Cucumber test cycle

if ENV['BROWSER'].eql? 'headless'
  require 'headless'
  puts "Starting headless"
  $browser_type =  "firefox"
  headless = Headless.new
  headless.start
  at_exit do
      puts "Destroying headless"
      headless.destroy
  end
else
  $browser_type = ENV['BROWSER']
end

Before do
  @env = ENV['ENVIRONMENT'] || 'dev'
  @env_info = YAML.load(File.open(File.join(Dir.pwd, 'config', 'env.yml')))

  if (ENV['PLATFORM'].eql? 'browserstack1')
    browserstackOptions = @env_info[ENV['PLATFORM']]
    url = "http://#{browserstackOptions['BS_USERNAME']}:#{browserstackOptions['BS_AUTHKEY']}@hub.browserstack.com/wd/hub"
    capabilities = Selenium::WebDriver::Remote::Capabilities.new
    if browserstackOptions['BS_AUTOMATE_OS']
      capabilities['os'] = browserstackOptions['BS_AUTOMATE_OS']
      capabilities['os_version'] = browserstackOptions['BS_AUTOMATE_OS_VERSION']
    else
      capabilities['platform'] = browserstackOptions['SELENIUM_PLATFORM'] || 'ANY'
    end
    capabilities['browser'] = browserstackOptions['SELENIUM_BROWSER'] || 'chrome'
    capabilities['browser_version'] = browserstackOptions['SELENIUM_VERSION'] if browserstackOptions['SELENIUM_VERSION']

    @browser = Watir::Browser.new(:remote,
      :url => url,
      :desired_capabilities => capabilities)
  else
    @browser = Watir::Browser.new :"#{$browser_type}"
  end

  #All page-objects initialization here
  @login = Login.new(@browser)
  @header = Header.new(@browser)
  @home = Home.new(@browser)
end

Before ('@login_logout_testing') do
  @login.loadAUT(@env_info, @env)
end

Before ('not @login_logout_testing') do
@login.login(@env_info, @env)
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
      @browser.screenshot.save("reports/normal_"+scenario.name+".png")
      embed("reports/normal_"+scenario.name+".png", 'image/png')
    end
  end
  @browser.close
end

After 'not @login_logout_testing' do
@header.logOut
@browser.close
end

After '@login_logout_testing' do
  @browser.close
end
