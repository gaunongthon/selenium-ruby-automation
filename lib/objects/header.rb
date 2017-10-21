class Header
  include UtilFunctions
  include Nokogiri

  def initialize(browser=nil)
    @dashboard = browser.a(:href => "/dashboard")
    @driver_map = browser.a(:href => "/driver-map")
    @user_management = browser.a(:href => "/user-management")
    @promotions = browser.a(:href => "/promotions")
    @claims = browser.a(:href => "/claims")
    @payments = browser.a(:href => "/payments")
    @settings = browser.a(:href => "/settings")
    @logout = browser.a(:href => "/logout")
    @b = browser
    create_getters
  end

  def logOut
    clickElement(@logout)
    wait_for_page_to_complete
  end

  def loadHome
    clickElement(@dashboard)
    wait_for_page_to_complete
  end

  def loadClaims
    clickElement(@claims)
    wait_for_page_to_complete
  end

  def loadSettings
    clickElement(@settings)
    wait_for_page_to_complete
  end

  def loadPayments
    clickElement(@payments)
    wait_for_page_to_complete
  end

  def loadUsers
    clickElement(@user_management)
    wait_for_page_to_complete
  end

  private
  def wait_for_page_to_complete(timeout = 20)
    FirePoll.poll("Page was not loaded", timeout) do
      @b.execute_script("return document.readyState;") == "complete"
    end
  end

end
