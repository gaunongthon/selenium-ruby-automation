Feature: Portal Settings Management

	Scenario Outline: Settings Navigating
			And I load Settings Page
			Then I count existing settings
			Then I verify <setting> key
			And I edit <setting> with new <value>
			Then I verify <setting> key

		Examples:
					| setting 		| value	|
					|"List Radius"	|"30000"|
