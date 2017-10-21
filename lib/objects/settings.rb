class Settings
  include UtilFunctions
  include Nokogiri

  def initialize(browser=nil)
    @settings_page_welcome_text = browser.element(:css => ".page-header > h1")
    @filteredResults = browser.elements(:css => ".show-grid.settingsRow.row")

    @b = browser
    create_getters
  end

  def getResults
    @filteredResults
  end

  def countResults
    @filteredResults.length
  end
end
