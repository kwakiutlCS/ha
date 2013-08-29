Feature: Create Transaction

	  
	  Scenario:
	  Given the following users exist:
	  |name|email|password|
	  |palerma57|k2543@k.pt|password|
	  And I am signed in as "palerma57"
	  And I am on the homepage
	  When I follow "Transactions"
	  And I fill in "Value" with "15.99"
	  And I fill in "Category" with "Food"
	  And I press "Create Transaction"
	  Then I should see "$15.99"