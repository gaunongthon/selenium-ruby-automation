class Users
  include UtilFunctions
  include Nokogiri

  def initialize(browser=nil)
    @user_page_text = browser.element(:css => ".pageTitle")
    @switch_users = browser.element(:css => ".bootstrap-switch-handle-on")
    @switch_cars = browser.element(:css => ".bootstrap-switch-handle-off")
    @paging_btn_1 = browser.element(:css => ".userTable > div:nth-child(1) > div:nth-child(1) > div:nth-child(1)")
    @paging_btn_2 = browser.element(:css => ".userTable > div:nth-child(1) > div:nth-child(2) > div:nth-child(1)")
    @filteredResults = browser.elements(:css => ".show-grid.userRow.row")
  #car:  html body div#app div#mainPage.mainApp div.content div.body div#mainContent.mainContent div.dashboardPage div.dashboardMainGrid.container-fluid div.row div.userTable div.userTableGrid.container-fluid div div div.show-grid.userRow.row
  #user: html body div#app div#mainPage.mainApp div.content div.body div#mainContent.mainContent div.dashboardPage div.dashboardMainGrid.container-fluid div.row div.userTable div.userTableGrid.container-fluid div div div.show-grid.userRow.row
    @b = browser
    create_getters
  end

  def getResults
    @filteredResults
  end

  def countResults
    @filteredResults.length
  end

  def clickNext
    clickElement(@paging_btn_1)
  end

  def clickPrevious
    clickElement(@paging_btn_1)
  end

  def switchCars
    clickElement(@switch_users)
  end

  def switchUsers
    clickElement(@switch_cars)
  end
end
