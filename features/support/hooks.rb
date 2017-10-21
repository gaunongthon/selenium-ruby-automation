require 'selenium-cucumber'
require_all 'lib'
#Cucumber provides a number of hooks which allow us to run blocks at various points in the Cucumber test cycle

Before do
  @env = ENV['ENVIRONMENT'] || 'default'
  $browser_type =  ENV['BROWSER'] || 'firefox'
  puts "Loading environment `#{@env}` and browser `#{@browser_type}`"
  @env_info = YAML.load(File.open(File.join(Dir.pwd, 'config', 'env.yml')))

  @browser = Watir::Browser.new :"#{$browser_type}"
  @login = Login.new(@browser)
  @home = Home.new(@browser)
  @header = Header.new(@browser)
  @claim = Claims.new(@browser)
  @user = Users.new(@browser)
  @setting = Settings.new(@browser)
end

Before ('@login_logout_testing') do
  @login.loadAUT(@env_info, @env)
end

Before ('not @login_logout_testing') do
@login.login(@env_info, @env)
end

After do |scenario|
  if scenario.failed?
    @browser.screenshot.save("reports/"+scenario.name+".jpeg")
    embed("reports/"+scenario.name+".jpeg", 'image/jpeg')
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
