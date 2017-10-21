Feature: Portal Claim

	@skip
	Scenario Outline: Claim Updates
		And I load Claims Page
		And I filter by <status> to count returned results
		And I filter new claims to <action>

		Examples:
					| status 		| action	|
					|"Accepted"	|"accept"	|
					|"Denied"		|"decline"|
		
	Scenario Outline: Verify Claim Updates
		And I load Claims Page
		And I filter by <statuses> to verify returned results

		Examples:
					| statuses 		|
					|"Accepted"	|
					|"Denied"		|
