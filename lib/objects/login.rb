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

  def loadAUT(env_info, env)
    stage_info = env_info[env]
    go(@b, stage_info['url'])
  end

  def login(env_info, env)
    loadAUT(env_info, env)
    stage_info = env_info[env]
    sendKeys(@username, stage_info['usr'])
    sendKeys(@password, stage_info['pwd'])
    clickElement(@login_btn)
  end

end
