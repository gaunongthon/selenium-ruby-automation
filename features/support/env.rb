$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '../../','lib'))

require 'rubygems'
require 'em/pure_ruby'
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

    $env = ENV['ENVIRONMENT'] || 'qa'
    @env_info = YAML.load(File.open(File.join(Dir.pwd, 'config', 'env.yml')))
    $platform = ENV['PLATFORM'] || 'local'
    puts "\nPlatform: #{$platform}"
    puts "\nEnvironment: #{$env}"
    $browserstackOptions = @env_info[$platform]

    #Loading env settings into global variables
    creds = @env_info[$env]
    URL = creds['url']
    USER = creds['usr']
    PWD = creds['pwd']

    puts "\nURL: #{URL}"
    puts "\nUSER: #{USER}"
    puts "\nPWD: #{PWD}"
