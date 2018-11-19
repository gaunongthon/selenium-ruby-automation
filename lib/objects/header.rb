require_all 'lib'
class Header
  include UtilFunctions
  include Nokogiri

  def initialize(browser=nil)
    @logout = browser.a(:css => ".logout")
    @contact_us = browser.a(:css => "#contact-link > a")
    @myaccount = browser.a(:css => ".account")
    @b = browser
    create_getters
  end

  def logOut
    clickElement(@logout)
  end

  def clickContactUs
    clickElement(@contact_us)
  end

  def clickMyAccount
    clickElement(@myaccount)
  end

end
