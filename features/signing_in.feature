Feature: Signing in
	  
	  Background:
	  Given the following users exist:
	  |name|email|password|
	  |palermafd|kfd@k.pt|password|

	  Scenario: Sign up
	  Given I am on the homepage
	  When I follow "Sign in"
	  And I fill in "Name" with "palermafd"
	  And I fill in "Password" with "password"
	  When I press "Sign in"
	  Then I should see "Signed in as palerma"
	  But I should not see "Sign in"
	  And I should not see "Sign up"