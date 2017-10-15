Feature: Su Portal smoke test

	@login_logout_testing
	Scenario: Verfiy Login
		And I am at Su Portal Login Page
		And I log in Su Portal as an admin
		Then I am at Su Portal Home Page
		And I log out Su Portal
		Then I am at Su Portal Login Page

	Scenario: Verify Home Page
		And I am at Su Portal Home Page
