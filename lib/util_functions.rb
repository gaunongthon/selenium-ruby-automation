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
      element.wait_until(&:present?)
      FirePoll.poll('waited too long', TIMEOUT) do
        element.present?
      end
  end

  def mouseOver(element)
    wait_for_transition(element)
    element.fire_event "onmouseover"
  end

  def scrollElementToCenter(element)
    wait_for_transition(element)
    element.scroll.to :center
  end

  def sendKeys(element, text)
      wait_for_transition(element)
      element.send_keys text
  end

  def clickElement(element)
      wait_for_transition(element)
      element.click
  end

  def doubleClickElement(element)
    wait_for_transition(element)
    element.double_click
  end

  def clickElementNoWait(element)
      element.click
  end

  def getElementAttr(elememt, attr)
    wait_for_transition(element)
    case attr
      when "class"
        elememt.attribute_value("class")
    end
  end

  def go(browser, url)
    browser.goto url
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
