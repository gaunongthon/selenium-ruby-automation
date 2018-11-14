Feature: Automation Practice Smoke test

	Scenario: Smoke test
		And I am at Automation Practice Login Page
		And I log in Automation Practice
		Then I am at Automation Practice Home Page
		And I click My Account
		And I want to manage "My addresses"
		And I click Contact Us
		And I log out Automation Practice
