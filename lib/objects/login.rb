class Login
  include UtilFunctions
  include Nokogiri

  def initialize(browser=nil)
    @username = browser.element(:id => "email")
    @password = browser.element(:id => "passwd")
    @login_page_welcome_text = browser.element(:css => "#login_form > h3")
    @login_btn = browser.element(:id => "SubmitLogin")
    @b = browser
    create_getters
  end

  def loadAUT(url)
    go(@b, url)
  end

  def login(usr, pwd)
    sendKeys(@username, usr)
    sendKeys(@password, pwd)
    clickElement(@login_btn)
  end

end
