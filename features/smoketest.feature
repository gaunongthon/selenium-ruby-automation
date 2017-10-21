Feature: Portal Smoke test

	@login_logout_testing @wip
	Scenario: Verfiy Login
		And I am at Su Portal Login Page
		And I log in Su Portal as an admin
		Then I am at Su Portal Home Page
		And I load Claims Page
		And I load Users Page
		And I log out Su Portal
