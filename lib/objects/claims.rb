class Claims
  include UtilFunctions
  include Nokogiri

  def initialize(browser=nil)
    @text_claim_page = browser.element(:css => ".columnHeaders > div:nth-child(3)")
    @statusDropdownFilter = browser.button(:id => "statusDropdownFilter")
    @options = browser.elements(:css => ".dropdown-menu > li")
    @filteredResults = browser.elements(:css => ".show-grid.claimBlock.row")
    @b = browser
    create_getters
  end

  def editClaim(item)
    edit = item.element(:css => "i.fa.fa-pencil")
    clickElement(edit)
  end

  def acceptClaim
    modalContainer = @b.element(:class => "modalContainer")
    wait_for_transition(modalContainer)
    desc = modalContainer.textarea(:id => "claim_decision_reason")
    sendKeys(desc, "Thanks-Auto accepted")
    btnApprove = modalContainer.button(:css => '.btn-success')
    clickElement(btnApprove)
  end

  def denyClaim
    modalContainer = @b.element(:class => "modalContainer")
    wait_for_transition(modalContainer)
    desc = modalContainer.textarea(:id => "claim_decision_reason")
    sendKeys(desc, "Need more info-Auto denied")
    btnDecline = modalContainer.button(:css => '.btn-danger')
    clickElement(btnDecline)
  end

  def selectOption(text)
    clickElement(@statusDropdownFilter)
    @options.each do |item|
      if item.text.eql? text
        #puts item.text
        clickElement(item)
      end
    end
  end

  def getResults
    @filteredResults
  end

  def countResults
    @filteredResults.length
  end
end
