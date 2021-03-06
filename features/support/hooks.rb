require 'selenium-cucumber'
require_all 'lib'

# Do something before each scenario
Before do
    # See: https://www.browserstack.com/automate/node#setting-os-and-browser
    if (($platform.include? 'browserstack_device')) ## For iOS-based and android-based browsers
      url = "http://#{@browserstackOptions['BS_USERNAME']}:#{@browserstackOptions['BS_AUTHKEY']}@hub.browserstack.com/wd/hub"
      capabilities = Selenium::WebDriver::Remote::Capabilities.new
      capabilities['realMobile'] = @browserstackOptions['realMobile']
      capabilities['device'] = @browserstackOptions['device']
      capabilities['os_version'] = @browserstackOptions['os_version']
      @browser = Watir::Browser.new(:remote,
        :url => url,
        :desired_capabilities => capabilities)
    elsif (($platform.include? 'browserstack') && (!$platform.include? 'device')) # For windows-based browsers
      url = "http://#{@browserstackOptions['BS_USERNAME']}:#{@browserstackOptions['BS_AUTHKEY']}@hub.browserstack.com/wd/hub"
      capabilities = Selenium::WebDriver::Remote::Capabilities.new
      capabilities['os'] = @browserstackOptions['os']
      capabilities['os_version'] = @browserstackOptions['os_version']
      capabilities['browserName'] = @browserstackOptions['browserName']
      capabilities['browser_version'] = @browserstackOptions['browser_version']
      @browser = Watir::Browser.new(:remote,
        :url => url,
        :desired_capabilities => capabilities)
    elsif ENV['BROWSER'].eql? 'headless'# For headless mode
      puts "\nStarting headless"
      options = Selenium::WebDriver::Chrome::Options.new
      options.add_argument('--headless')
      @browser = Watir::Browser.new :"chrome", options: options
    elsif ((ENV['BROWSER'].eql? 'firefox') | (ENV['BROWSER'].eql? 'chrome'))# For gecko firefox or chrome
      @browser_type = ENV['BROWSER']
      @browser = Watir::Browser.new :"#{@browser_type}"
    end
    @browser.driver.manage.timeouts.implicit_wait = TIMEOUT
    @browser.driver.manage.window.maximize
    @browser.driver.manage.delete_all_cookies

    #All page-objects initialization here
    @login = Login.new(@browser)
    @header = Header.new(@browser)
    @home = Home.new(@browser)

    @login.loadAUT(URL)
end

# Do something after each scenario
After do |scenario|
   if scenario.failed?
     time = Time.new
     time = time.hour.to_s + "_" + time.min.to_s
     screenshot = "reports/fail_"+scenario.name+"_"+time+".png"
     @browser.screenshot.save(screenshot)
     embed(screenshot, 'image/png')
  end
  puts "\nClosing browser ..."
  @browser.close
  @browser.quit
end
