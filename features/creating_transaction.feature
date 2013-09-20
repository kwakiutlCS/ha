Feature: Create Transaction

	  
	  Scenario: normal
	  Given the initial categories exist
	  Given the following users exist:
	  |name|email|password|
	  |palerma57|k2543@k.pt|password|
	  And I am signed in as "palerma57"
	  And I am on the homepage
	  When I follow "Transactions"
	  And I fill in "transaction_value_expense" with "15.99"
	  And within "#new_transaction_expense" I press "Create Transaction"
	  Then I should see "$15.99"

	  Scenario: large ammount
	  Given the initial categories exist
	  Given the following users exist:
	  |name|email|password|
	  |palerma57|k2543@k.pt|password|
	  And I am signed in as "palerma57"
	  And I am on the homepage
	  When I follow "Transactions"
	  And I fill in "transaction_value_expense" with "1000000000"
	  And within "#new_transaction_expense" I press "Create Transaction"
	  Then I should not see "$1000000000"
	  