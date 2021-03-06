Feature: Hidden links

	  Scenario:
	  Given I am on the homepage
	  Then I should not see "Transactions"

	  Scenario:
	  Given the initial categories exist
	  Given the following users exist:
	  |name|email|password|
	  |trengo|df@jf.pt|password|
	  And I am signed in as "trengo"
	  When I am on the homepage
	  Then I should see "Transactions"