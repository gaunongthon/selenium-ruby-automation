require_all 'lib'
class Home
  include UtilFunctions
  include Nokogiri

  def initialize(browser=nil)
    @home_page_welcome_text = browser.element(:css => ".page-heading")
    @managed_options = browser.elements(:css => "div.col-sm-6 > ul > li > a > span")
    @b = browser
    create_getters
  end

  def returnToMyAccount
    if (!(getText(@home_my_account_text).downcase.eql? HOME_PAGE_WELCOME_TEXT))
      clickElement(@my_account)
    end
  end

  def select_managed_option(selectedOption)
    @managed_options.each do |item|
      if getText(item).eql? selectedOption
        clickElement(item)
      end
    end
  end

end
