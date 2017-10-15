class Authenticate
  include UtilFunctions

  def loadAUT(env_info, browser)
    stage_info = env_info['stage-su-portal']
    go(browser, stage_info['url'])
    wait_for_page_to_complete(browser)
  end

  def login(env_info, login_page, browser, scenario=nil)
    stage_info = env_info["stage-su-portal"]
    browser.goto stage_info['url']
    wait_for_page_to_complete(browser)
    sendKeys(login_page.username, stage_info['usr'])
    sendKeys(login_page.password, stage_info['pwd'])
    clickElement(login_page.login_btn)
  end

  def logout(home_page)
      clickElement(home_page.logout_btn)
  end

  private
  def wait_for_page_to_complete(browser, timeout = 20)
    FirePoll.poll("Page was not loaded", timeout) do
      browser.execute_script("return document.readyState;") == "complete"
    end
  end
end
