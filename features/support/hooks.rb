require 'selenium-cucumber'
require_all 'lib'
#Cucumber provides a number of hooks which allow us to run blocks at various points in the Cucumber test cycle

Before ('@login_logout_testing') do
  # Do something before each scenario.
  @browser = Watir::Browser.new :"#{$browser_type}"
  @suPortalLogin = SuPortalLoginPage.new(@browser)
  @suPortalHome = SuPortalHomePage.new(@browser)
  @env_info = YAML.load(File.open(File.join(Dir.pwd, 'config', 'env.yml')))
  Authenticate.new.loadAUT(@env_info, @browser)
end

After ('@login_logout_testing') do
  @browser.close
end

Before ('~@login_logout_testing') do
# Do something before each scenario.
@browser = Watir::Browser.new :"#{$browser_type}"
@suPortalLogin = SuPortalLoginPage.new(@browser)
@suPortalHome = SuPortalHomePage.new(@browser)
@env_info = YAML.load(File.open(File.join(Dir.pwd, 'config', 'env.yml')))
Authenticate.new.login(@env_info, @suPortalLogin, @browser)
end

After '~@login_logout_testing' do
@suPortalHome = SuPortalHomePage.new(@browser)
Authenticate.new.logout(@suPortalHome)
@browser.close
end

After do |scenario|
  if scenario.failed?
    @browser.screenshot.save("reports/"+scenario.name+".jpeg")
    embed("reports/"+scenario.name+".jpeg", 'image/jpeg')
  end
end
