Feature: Portal User Car Management

	Scenario: Users Navigating
			And I load Users Page
			Then I verify returned results
			And I count returned results
			Then I click next page
			Then I click previous page
			And I switch to manage Cars
			And I count returned results

		Scenario: Users Navigating
				And I load Users Page
				And I switch to manage Cars
				Then I verify returned results
				And I count returned results
				Then I click next page
				Then I click previous page
				And I switch to manage Users
				And I count returned results
