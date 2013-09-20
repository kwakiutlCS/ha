Feature: Signing in
	  
	  Background:
	  And the initial categories exist
	  Given the following users exist:
	  |name|email|password|
	  |palerma44|kfd43@k.pt|password|
	  

	  Scenario: Sign up
	  Given I am on the homepage
	  When I follow "Sign in"
	  And I fill in "Name" with "palerma44"
	  And I fill in "Password" with "password"
	  When I press "Sign in"
	  Then I should see "Palerma44"
	  But I should not see "Sign in"
	  And I should not see "Sign up"