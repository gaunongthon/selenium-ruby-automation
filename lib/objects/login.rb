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
    wait_for_page_to_complete
  end

  def login(env_info, env)
    loadAUT(env_info, env)
    stage_info = env_info[env]
    sendKeys(@username, stage_info['usr'])
    sendKeys(@password, stage_info['pwd'])
    clickElement(@login_btn)
  end

  private
  def wait_for_page_to_complete(timeout = 20)
    FirePoll.poll("Page was not loaded", timeout) do
      @b.execute_script("return document.readyState;") == "complete"
    end
  end
end
