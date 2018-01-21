$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '../../','lib'))

require 'rubygems'
require 'selenium-cucumber'
require 'require_all'
require 'fire_poll'
require 'page-object'
require 'page-object/elements'
require 'page-object/page_factory'
require 'active_support/all'
require 'selenium-webdriver'
require 'nokogiri'
require 'pry'
require 'httparty'
require 'watir-scroll'
require_all 'lib'

ENV['FRAMEWORK'] = File.expand_path('.')

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
  $browser = Watir::Browser.new(:remote,
    :url => url,
    :desired_capabilities => capabilities)
elsif ((platform.include? 'browserstack') && (!platform.include? 'device')) # For windows-based browsers
  url = "http://#{browserstackOptions['BS_USERNAME']}:#{browserstackOptions['BS_AUTHKEY']}@hub.browserstack.com/wd/hub"
  capabilities = Selenium::WebDriver::Remote::Capabilities.new
  capabilities['os'] = browserstackOptions['os']
  capabilities['os_version'] = browserstackOptions['os_version']
  capabilities['browserName'] = browserstackOptions['browserName']
  capabilities['browser_version'] = browserstackOptions['browser_version']
  $browser = Watir::Browser.new(:remote,
    :url => url,
    :desired_capabilities => capabilities)
elsif ENV['BROWSER'].eql? 'headless'# For headless mode
  require 'headless'
  puts "Starting headless"
  $browser_type = "firefox"
  headless = Headless.new
  headless.start
  $browser = Watir::Browser.new :"#{$browser_type}"
  at_exit do
      puts "Destroying headless"
      headless.destroy
  end
elsif ENV['BROWSER'].eql? 'firefox'# For gecko firefox
  $browser_type = ENV['BROWSER']
  $browser = Watir::Browser.new :"#{$browser_type}"
end

#Loading env settings into global variables
selected_env_info = @env_info[@env]
URL = selected_env_info['url']
USER = selected_env_info['usr']
PWD = selected_env_info['pwd']

puts URL
puts USER
puts PWD
