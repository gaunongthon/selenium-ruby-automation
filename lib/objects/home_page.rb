class SuPortalHomePage
  include UtilFunctions
  include Nokogiri

#think about solving problems with waiting for elements while creating them
#but this is not a final solution
  def initialize(browser=nil)
    @home_page_welcome_text = browser.element(:css => ".pageTitle")
    @logout_btn = browser.element(:css => ".nav > li:nth-child(8) > a:nth-child(1)")
    create_getters
  end
end
