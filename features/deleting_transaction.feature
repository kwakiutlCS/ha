Feature: Editing Transaction

	  
	  Scenario:
	  Given the following users exist:
	  |name|email|password|
	  |palerma|k2543@k.pt|password|
	  And the following transactions exist:
	  |value_cents|date|
	  |34|2013-08-29|
	  And I am signed in as "palerma"
	  And I am on the homepage
	  When I follow "Transactions"
	  And I follow "edit"
	  And I fill in "transaction_expense_value" with "54"
	  Then I should not see "$34.00"
	  But I should see "$54.00"