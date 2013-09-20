Feature: Sign out

	  Scenario:
	  Given the initial categories exist
	  Given the following users exist:
	  |name|email|password|
	  |palermafd|kfd@k.pt|password|
	  And I am signed in as "palermafd"
	  When I follow "Sign out"
	  Then I should see "Sign in"
	  And I should see "Sign up"
	  And I should be on the homepage