require 'selenium-cucumber'
require_all 'lib'

# Do something before each scenario
Before do
    # See: https://www.browserstack.com/automate/node#setting-os-and-browser
    if (($platform.include? 'browserstack_device')) ## For iOS-based and android-based browsers
      url = "http://#{$browserstackOptions['BS_USERNAME']}:#{$browserstackOptions['BS_AUTHKEY']}@hub.browserstack.com/wd/hub"
      capabilities = Selenium::WebDriver::Remote::Capabilities.new
      capabilities['realMobile'] = $browserstackOptions['realMobile']
      capabilities['device'] = $browserstackOptions['device']
      capabilities['os_version'] = $browserstackOptions['os_version']
      $browser = Watir::Browser.new(:remote,
        :url => url,
        :desired_capabilities => capabilities)
    elsif (($platform.include? 'browserstack') && (!$platform.include? 'device')) # For windows-based browsers
      url = "http://#{$browserstackOptions['BS_USERNAME']}:#{$browserstackOptions['BS_AUTHKEY']}@hub.browserstack.com/wd/hub"
      capabilities = Selenium::WebDriver::Remote::Capabilities.new
      capabilities['os'] = $browserstackOptions['os']
      capabilities['os_version'] = $browserstackOptions['os_version']
      capabilities['browserName'] = $browserstackOptions['browserName']
      capabilities['browser_version'] = $browserstackOptions['browser_version']
      $browser = Watir::Browser.new(:remote,
        :url => url,
        :desired_capabilities => capabilities)
    elsif ENV['BROWSER'].eql? 'headless'# For headless mode
      require 'headless'
      puts "Starting headless"
      options = Selenium::WebDriver::Chrome::Options.new
      options.add_argument('--headless')
      $browser = Watir::Browser.new :"chrome", options: options
    elsif ((ENV['BROWSER'].eql? 'firefox') | (ENV['BROWSER'].eql? 'chrome'))# For gecko firefox or chrome
      $browser_type = ENV['BROWSER']
      $browser = Watir::Browser.new :"#{$browser_type}"
    end
    $browser.driver.manage.timeouts.implicit_wait = TIMEOUT
    $browser.driver.manage.window.maximize
    $browser.driver.manage.delete_all_cookies

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
