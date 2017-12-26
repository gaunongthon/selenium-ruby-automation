require 'selenium-cucumber'
require_all 'lib'

#Cucumber provides a number of hooks which allow us to run blocks at various points in the Cucumber test cycle
Before do
  @env = ENV['ENVIRONMENT'] || 'dev'
  @env_info = YAML.load(File.open(File.join(Dir.pwd, 'config', 'env.yml')))
  platform = ENV['PLATFORM'] || 'headless'
  puts "\nPlatform: #{platform}"
  puts "Environment: #{@env}"
  browserstackOptions = @env_info[platform]

  # See: https://www.browserstack.com/automate/node#setting-os-and-browser
  if ((platform.include? 'browserstack_device')) ## For iOS-based and android-based browsers
    url = "http://#{browserstackOptions['BS_USERNAME']}:#{browserstackOptions['BS_AUTHKEY']}@hub.browserstack.com/wd/hub"
    capabilities = Selenium::WebDriver::Remote::Capabilities.new
    capabilities['realMobile'] = browserstackOptions['realMobile']
    capabilities['device'] = browserstackOptions['device']
    capabilities['os_version'] = browserstackOptions['os_version']
    @browser = Watir::Browser.new(:remote,
      :url => url,
      :desired_capabilities => capabilities)
  elsif ((platform.include? 'browserstack') && (!platform.include? 'device')) # For windows-based browsers
    url = "http://#{browserstackOptions['BS_USERNAME']}:#{browserstackOptions['BS_AUTHKEY']}@hub.browserstack.com/wd/hub"
    capabilities = Selenium::WebDriver::Remote::Capabilities.new
    capabilities['os'] = browserstackOptions['os']
    capabilities['os_version'] = browserstackOptions['os_version']
    capabilities['browserName'] = browserstackOptions['browserName']
    capabilities['browser_version'] = browserstackOptions['browser_version']
    @browser = Watir::Browser.new(:remote,
      :url => url,
      :desired_capabilities => capabilities)
  elsif ENV['BROWSER'].eql? 'headless'# For headless mode
    require 'headless'
    puts "Starting headless"
    $browser_type = "firefox"
    headless = Headless.new
    headless.start
    @browser = Watir::Browser.new :"#{$browser_type}"
    at_exit do
        puts "Destroying headless"
        headless.destroy
    end
  elsif ENV['BROWSER'].eql? 'firefox'# For gecko firefox
    $browser_type = ENV['BROWSER']
    @browser = Watir::Browser.new :"#{$browser_type}"
  end

  #Loading env settings into global variables
  selected_env_info = @env_info[@env]
  @url = selected_env_info['url']
  @usr_name = selected_env_info['usr']
  @pwd = selected_env_info['pwd']

  puts @url
  puts @usr_name
  puts @pwd

  #All page-objects initialization here
  @login = Login.new(@browser)
  @header = Header.new(@browser)
  @home = Home.new(@browser)
end

Before ('not @auto_login_logout') do
  @login.loadAUT(@env_info, @env)
end

Before ('@auto_login_logout') do
  @login.loadAUT(@env_info, @env)
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

After '@auto_login_logout' do
@header.logOut
@browser.close
end

After 'not @auto_login_logout' do
  @browser.close
end
