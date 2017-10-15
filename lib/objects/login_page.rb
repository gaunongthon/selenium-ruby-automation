class SuPortalLoginPage
  include UtilFunctions
  include Nokogiri

  def initialize(browser=nil)
    @username = browser.element(:id => "username")
    @password = browser.element(:id => "password")
    @login_page_welcome_text = browser.element(:css => ".loginTitle")
    @login_btn = browser.element(:css => ".btn")
    create_getters
  end
end
