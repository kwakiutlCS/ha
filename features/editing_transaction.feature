Feature: Delete Transaction

	  
	  Scenario:
	  Given the following users exist:
	  |name|email|password|
	  |palerma|k2543@k.pt|password|
	  And the following transactions exist:
	  |value_cents|date|user|
	  |34|2013-09-01|palerma|
	  And I am signed in as "palerma"
	  And I am on the homepage
	  When I follow "Transactions"
	  Then I should see "delete"
	  When I follow "delete"
	  Then I should not see "$34.00"