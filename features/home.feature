Feature: Portal Home Page

	Scenario: Users Navigating
			And I load Home Page
			And I load request taxi form
			Then I search for passenger "hab" with phone number "5064470396"
			And I input "45.944083, -66.666315" as pick-up coordinates
			And I type "275 Main St, Fredericton, NB" as destination location
			Then I hit Estimate button
