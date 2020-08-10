class LoginPage < Page

  def initialize(browser)
    @browser = browser
    super
    navigate_to_page
  end

end