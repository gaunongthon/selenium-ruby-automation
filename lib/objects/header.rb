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
    wait_for_page_to_complete
  end

  def clickContactUs
    clickElement(@contact_us)
    wait_for_page_to_complete
  end

  def clickMyAccount
    clickElement(@myaccount)
    wait_for_page_to_complete
  end

  private
  def wait_for_page_to_complete(timeout = 20)
    FirePoll.poll("Page was not loaded", timeout) do
      @b.execute_script("return document.readyState;") == "complete"
    end
  end

end
