Feature: view expenses


	  Background:
	  Given the following users exist:
	  |name|email|password|
	  |palerma|sjfk@kjlwfg.com|password|
	  And the following categories exist:
	  |title|transaction_type|
	  |food|false|
	  |health|false|
	  And "palerma" has all the categories
	  And the following transactions exist:
	  |date|transaction_type|value_cents|user|
	  |2013-08-28|false|1526|palerma|
	  |2013-09-01|false|1426|palerma|
	  |2013-09-04|false|2526|palerma|
	  |2013-08-02|false|526|palerma|
	  

	  Scenario: view default transactions
	  Given I am on the homepage
	  And I am signed in as "palerma"
	  When I follow "Transactions"
	  Then I should not see "$15.26"
	  But I should see "$25.26"

	  @javascript
	  Scenario: view session transactions
	  Given I am on the homepage
	  And I am signed in as "palerma"
	  When I follow "Transactions"
	  Then I should not see "$15.26"
	  When I select "Current Year" from "date_expense_select_fields"
	  Then I should see "$15.26"
	  When I am on the homepage
	  And I follow "Transactions"
	  Then I should see "$15.26"
	  