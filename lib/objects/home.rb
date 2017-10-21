class Home
  include UtilFunctions
  include Nokogiri

  def initialize(browser=nil)
    @home_page_welcome_text = browser.element(:css => ".pageTitle")
    @request_taxi = browser.element(:css => "button.btn.btn-default")

    @user_phone_number = browser.element(:id => "user_phone_number")
    @search = browser.element(:css => ".fa-search")

    #@foundResults = browser.elements(:css => "div.passengerContainer > div.passengerRow > div > div > div > span")
    @foundResults = browser.elements(:css => "div.passengerContainer.col-lg-9.col-lg-offset-1.col-md-9.col-md-offset-1 div.passengerRow.row div div.row div span")
    @from = browser.element(:id => "from_coordinates")
    @from_location_dropdown = browser.element(:id => "from_location_dropdown")
    @from_location_options = browser.elements(:css => ".open > ul > li > a")

    @to = browser.element(:id => "to_coordinates")
    @to_location_dropdown = browser.element(:id => "to_location_dropdown")
    @to_location_options = browser.elements(:css => ".open > ul > li > a")

    @okButton = browser.element(:css => ".okButton")

    @b = browser
    create_getters
  end

  def loadRequestTaxiForm
    clickElement(@request_taxi)
  end

  def selectPassenger(text, number)
    sendKeys(@user_phone_number,number)
    clickElement(search)
    mouseOver(@foundResults[0])
    @foundResults.each do |item|
      puts item.text
      if item.text.include? text
        clickElement(item)
      end
    end
  end

  def setFromLocationByCoordinate(coordinates)
    clickElement(@from_location_dropdown)
    @from_location_options.each do |item|
      puts item.text
      if item.text.eql? "Lat/Lng"
        clickElement(item)
      end
    end
    sendKeys(@from, coordinates)
  end

  def setFromLocationByLocation(location)
    clickElement(@from_location_dropdown)
    @from_location_options.each do |item|
      puts item.text
      if item.text.eql? "Location String"
        clickElement(item)
      end
    end
    sendKeys(@from, location)
  end

  def setToLocationByCoordinate(coordinates)
    clickElement(@to_location_dropdown)
    @to_location_options.each do |item|
      puts item.text
      if item.text.eql? "Lat/Lng"
        clickElement(item)
      end
    end
    sendKeys(@to, coordinates)
  end

  def setToLocationByLocation(location)
    clickElement(@to_location_dropdown)
    @to_location_options.each do |item|
      puts item.text
      if item.text.eql? "Location String"
        clickElement(item)
      end
    end
    sendKeys(@to, location)
  end

  def hitEstimate
    clickElement(@okButton)
  end
end
