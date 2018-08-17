module UtilFunctions

  def create_getters
    begin
      instance_variables.each do |v|
        define_singleton_method(v.to_s.tr('@','')) do
          instance_variable_get(v)
        end
      end
    rescue
      "Element not yet found"
    end
  end

  def wait_for_transition(element)
      element.wait_until_present
      FirePoll.poll('waited too long', 20) do
        element.present?
      end
  end

  def mouseOver(element)
    element.fire_event "onmouseover"
  end

  def scrollElementToCenter(element)
    element.scroll.to :center
  end

  def sendKeys(element, text)
      wait_for_transition(element)
      element.send_keys text
  end

  def clickElement(element)
      wait_for_transition(element)
      element.click
      sleep(WAIT_DEFAULT)
  end

  def doubleClickElement(element)
    wait_for_transition(element)
    element.double_click
    sleep(WAIT_DEFAULT)
  end

  def clickElementNoWait(element)
      element.click
  end

  def getElementAttr(elememt, attr)
    case attr
      when "class"
        elememt.attribute_value("class")
    end
  end

  def go(browser, url)
    browser.goto url
    sleep(WAIT_DEFAULT)
  end

  # method to switch frame
  def switch_iframe(iFrameId)
    @browser.driver.switch_to.frame(iFrameId)
  end

  # method to switch to main window
  def switch_to_main_content
   @browser.driver.switch_to.default_content
  end
end
