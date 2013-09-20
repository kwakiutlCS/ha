Feature: Signing up
	  

	  Scenario: Sign up
	  Given the initial categories exist
	  Given I am on the homepage
	  When I follow "Sign up"
	  And I fill in "Name" with "palerma"
	  And I fill in "Email" with "k@k.pt"
	  And I fill in "Password" with "password"
	  And I fill in "Password confirmation" with "password"
	  Then I should see "Sign in"
	  When I press "Sign up"
	  Then I should see "successfully"
	  And I should see "Palerma"
	  But I should not see "Sign in"
	  And I should not see "Sign up"